using Microsoft.AspNetCore.Mvc;
using Contracts;
using Entities.DataTransferObjects;
using Entities.Models;
using Mapster;
using System.Net;
using Student_WebApi_ADO_NET.ViewModels;

namespace Student_WebApi_ADO_NET.Controllers
{
    public class StudentController_ADO_Net_Reflection : Controller
    {
        private ILoggerManager _logger;

        public StudentController_ADO_Net_Reflection(ILoggerManager logger)
        {
            this._logger = logger;
        }

        // POST: api/Student
        [HttpPost("CreateStudent_ADO_Net_Reflection")]
        public async Task<IActionResult> CreateStudent_ADO_Net_Reflection([FromBody] StudentForSaveDto StudentForSaveDto_Object,
                                                                           string UserName = "No Name")
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    this._logger.LogError($"ModelState is Invalid for {UserName} in action CreateStudent_ADO_Net_Reflection");
                    return BadRequest(ModelState);
                }

                Student Student_Object = new Student();
                Student_Object = StudentForSaveDto_Object.Adapt<Student>();

                // Fuld Generisk metode
                int SaveResult = Student_Object.InsertObjectToDatabase<Student>(Student.TABLE_NAME);

                if (SaveResult >= 0)
                {
                    return Ok($"Student : {Student_Object.StudentName} oprettet !!!");
                }
                else
                {
                    return BadRequest($"Noget gik galt, da {Student_Object.StudentName} : skulle oprettes !!!");
                }
            }
            catch (Exception Error)
            {
                _logger.LogError($"Noget gik galt med CreateStudent_ADO_Net_Reflection action for {UserName}: {Error.Message}");
                return StatusCode((int)HttpStatusCode.InternalServerError, $"Internal server error : {Error.ToString()}");
            }
        }
        
        // DELETE: api/Student/{id}
        [HttpDelete("DeleteStudent_ADO_Net_Reflection/{id}")]
        public async Task<IActionResult> DeleteStudent_ADO_Net_Reflection(int id, string UserName = "No Name")
        {
            try
            {
                Student studentToDelete = new Student { StudentID = id };

                int deleteResult = studentToDelete.DeleteObjectFromDatabase<Student>(Student.TABLE_NAME);

                if (deleteResult > 0)
                {
                    return Ok($"Student med ID: {id} fjernede successfully.");
                }
                else
                {
                    return BadRequest($"Failed to delete student with ID: {id}. It may not exist.");
                }
            }
            catch (Exception Error)
            {
                _logger.LogError($"Noget gik galt med DeleteStudent_ADO_Net_Reflection action for {UserName}: {Error.Message}");
                return StatusCode((int)HttpStatusCode.InternalServerError, $"Internal server error : {Error.ToString()}");
            }
        }
        
        // PUT: api/Student/{id}
        [HttpPut("UpdateStudent_ADO_Net_Reflection/{id}")]
        public async Task<IActionResult> UpdateStudent_ADO_Net_Reflection(int id, [FromBody] StudentForSaveDto StudentForSaveDto_Object, string UserName = "No Name")
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    this._logger.LogError($"ModelState is Invalid for {UserName} in action UpdateStudent_ADO_Net_Reflection");
                    return BadRequest(ModelState);
                }

                Student existingStudent = new Student { StudentID = id };
                existingStudent = StudentForSaveDto_Object.Adapt(existingStudent);

                int updateResult = existingStudent.UpdateObjectInDatabase<Student>(Student.TABLE_NAME);

                if (updateResult > 0)
                {
                    return Ok($"Student med ID: {id} opdateret !!!");
                }
                else
                {
                    return BadRequest($"Failed to update student with ID: {id}. It may not exist.");
                }
            }
            catch (Exception Error)
            {
                _logger.LogError($"Noget gik galt med UpdateStudent_ADO_Net_Reflection action for {UserName}: {Error.Message}");
                return StatusCode((int)HttpStatusCode.InternalServerError, $"Internal server error : {Error.ToString()}");
            }
        }
        
        // GET: api/Student
        [HttpGet("GetStudents_ADO_Net_Reflection")]
        public async Task<IActionResult> GetStudents_ADO_Net_Reflection(string UserName = "No Name")
        {
            try
            {
                List<Student> students = OrmReflection.GetData<Student>("dbo.Core_8_0_Students");

                if (students.Count > 0)
                {
                    return Ok(students);
                }
                else
                {
                    return NotFound("Ingen students fundet.");
                }
            }
            catch (Exception Error)
            {
                _logger.LogError(
                    $"Noget gik galt med GetStudents_ADO_Net_Reflection action for {UserName}: {Error.Message}");
                return StatusCode((int)HttpStatusCode.InternalServerError,
                    $"Internal server error : {Error.ToString()}");
            }
        }
    }
}
