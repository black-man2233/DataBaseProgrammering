using Microsoft.EntityFrameworkCore.Migrations.Operations;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;
using Microsoft.Data.SqlClient;
using System.ComponentModel.DataAnnotations;

namespace Entities.Models
{
    public static class OrmReflection
    {
        private static SqlConnection? DatabaseConnection = null;

        public static int InsertObjectToDatabase<T>(this T obj, string tableName)
        {
            int Result = 0;
            Type type = typeof(T);

            PropertyInfo[] properties = type.GetProperties();

            PropertyInfo primaryKeyProperty =
                properties.FirstOrDefault(p => p.GetCustomAttributes(typeof(KeyAttribute), true).Length > 0);

            StringBuilder sql = new StringBuilder();
            sql.Append($"INSERT INTO {tableName} (");

            List<string> columnNames = new List<string>();
            List<object> parameters = new List<object>();
            foreach (PropertyInfo property in properties)
            {
                if (property != primaryKeyProperty &&
                    (property.PropertyType.IsPrimitive || property.PropertyType == typeof(string)))
                {
                    columnNames.Add(property.Name);
                    parameters.Add(property.GetValue(obj));
                }
            }

            sql.Append(string.Join(", ", columnNames));
            sql.Append(") VALUES (");
            sql.Append(string.Join(", ", parameters.Select(p => "@p" + parameters.IndexOf(p))));
            sql.Append(");");

            using (SqlConnection connection = new SqlConnection(GetSqlConnectionString()))
            {
                using (SqlCommand command = new SqlCommand(sql.ToString(), connection))
                {
                    for (int i = 0; i < parameters.Count; i++)
                    {
                        command.Parameters.AddWithValue("@p" + i, parameters[i]);
                    }

                    connection.Open();
                    Result = command.ExecuteNonQuery();
                    if (Result < 0)
                    {
                        Console.WriteLine("Noget gik galt under Save operationen !!!");
                    }
                }

                connection.Close();
            }

            return Result;
        }

        public static int DeleteObjectFromDatabase<T>(this T obj, string tableName)
        {
            int Result = 0;
            Type type = typeof(T);

            PropertyInfo[] properties = type.GetProperties();

            PropertyInfo primaryKeyProperty =
                properties.FirstOrDefault(p => p.GetCustomAttributes(typeof(KeyAttribute), true).Length > 0);
            if (primaryKeyProperty == null)
            {
                Console.WriteLine("Ingen primary key fundet !");
                return Result;
            }

            object primaryKeyValue = primaryKeyProperty.GetValue(obj);

            if (primaryKeyValue == null)
            {
                Console.WriteLine("Primary key value er null.");
                return Result;
            }

            StringBuilder sql = new StringBuilder();
            sql.Append($"DELETE FROM {tableName} WHERE {primaryKeyProperty.Name} = @p0;");

            using (SqlConnection connection = new SqlConnection(GetSqlConnectionString()))
            {
                using (SqlCommand command = new SqlCommand(sql.ToString(), connection))
                {
                    command.Parameters.AddWithValue("@p0", primaryKeyValue);

                    try
                    {
                        connection.Open();
                        Result = command.ExecuteNonQuery();
                        if (Result < 0)
                        {
                            Console.WriteLine("Noget gik galt under Save operationen !!!");
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Exception occurred: {ex.Message}");
                    }
                }
            }

            return Result;
        }

        public static int UpdateObjectInDatabase<T>(this T obj, string tableName)
        {
            int Result = 0;
            Type type = typeof(T);

            PropertyInfo[] properties = type.GetProperties();

            PropertyInfo primaryKeyProperty =
                properties.FirstOrDefault(p => p.GetCustomAttributes(typeof(KeyAttribute), true).Length > 0);
            if (primaryKeyProperty == null)
            {
                Console.WriteLine("Ingen primary key fundet !");
                return Result;
            }

            object primaryKeyValue = primaryKeyProperty.GetValue(obj);
            if (primaryKeyValue == null)
            {
                Console.WriteLine("Primary key value er null.");
                return Result;
            }

            StringBuilder sql = new StringBuilder();
            sql.Append($"UPDATE {tableName} SET ");

            List<string> setClauses = new List<string>();
            List<object> parameters = new List<object>();
            foreach (PropertyInfo property in properties)
            {
                if (property != primaryKeyProperty &&
                    (property.PropertyType.IsPrimitive || property.PropertyType == typeof(string)))
                {
                    setClauses.Add($"{property.Name} = @p{parameters.Count}");
                    parameters.Add(property.GetValue(obj));
                }
            }

            sql.Append(string.Join(", ", setClauses));
            sql.Append($" WHERE {primaryKeyProperty.Name} = @p{parameters.Count};");

            using (SqlConnection connection = new SqlConnection(GetSqlConnectionString()))
            {
                using (SqlCommand command = new SqlCommand(sql.ToString(), connection))
                {
                    for (int i = 0; i < parameters.Count; i++)
                    {
                        command.Parameters.AddWithValue("@p" + i, parameters[i]);
                    }

                    command.Parameters.AddWithValue("@p" + parameters.Count, primaryKeyValue);

                    try
                    {
                        connection.Open();
                        Result = command.ExecuteNonQuery();
                        if (Result < 0)
                        {
                            Console.WriteLine("Noget gik galt under Save operationen !!!");
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Exception occurred: {ex.Message}");
                    }
                }
            }

            return Result;
        }

        public static List<T> GetData<T>(string tableName)
        {
            List<T> resultList = new List<T>();
            Type type = typeof(T);

            StringBuilder sql = new StringBuilder();
            sql.Append($"SELECT * FROM {tableName}");

            Console.WriteLine($"Executing query: {sql.ToString()}");

            using (SqlConnection connection = new SqlConnection(GetSqlConnectionString()))
            {
                using (SqlCommand command = new SqlCommand(sql.ToString(), connection))
                {
                    try
                    {
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                T obj = Activator.CreateInstance<T>();
                                PropertyInfo[] properties = type.GetProperties();

                                foreach (var property in properties)
                                {
                                    if (property.PropertyType.IsGenericType || property.PropertyType.IsClass)
                                    {
                                        continue;
                                    }

                                    if (!reader.IsDBNull(reader.GetOrdinal(property.Name)))
                                    {
                                        object value = reader[property.Name];
                                        property.SetValue(obj, value);
                                    }
                                }

                                resultList.Add(obj);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error occurred while fetching data: {ex.Message}");
                    }
                }
            }
            return resultList;
        }

        private static void OpenDatabaseConnection()
        {
            if (null == DatabaseConnection)
            {
                DatabaseConnection = new SqlConnection(GetSqlConnectionString());

                DatabaseConnection.Open();
            }
        }

        private static void CloseDatabaseConnection()
        {
            if (null != DatabaseConnection)
            {
                DatabaseConnection.Close();
                DatabaseConnection = null;
            }
        }

        private static string GetSqlConnectionString()
        {
            var sqlConnectionSB = new SqlConnectionStringBuilder
            {
                DataSource = "(localdb)\\mssqllocaldb",
                InitialCatalog = "Student_WebApi_Core_8_0",
                TrustServerCertificate = true,
            };
            return sqlConnectionSB.ToString();
        }
    }
}