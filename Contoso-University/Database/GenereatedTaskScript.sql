USE [SchoolContext6]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 21/11/2024 09.00.15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseID] [int] NOT NULL,
	[Title] [nvarchar](50) NULL,
	[Credits] [int] NOT NULL,
	[DepartmentID] [int] NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseAssignment]    Script Date: 21/11/2024 09.00.15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseAssignment](
	[InstructorID] [int] NOT NULL,
	[CourseID] [int] NOT NULL,
 CONSTRAINT [PK_CourseAssignment] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC,
	[InstructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 21/11/2024 09.00.15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Budget] [money] NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[InstructorID] [int] NULL,
	[RowVersion] [timestamp] NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrollment]    Script Date: 21/11/2024 09.00.15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollment](
	[EnrollmentID] [int] IDENTITY(1,1) NOT NULL,
	[CourseID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[Grade] [int] NULL,
 CONSTRAINT [PK_Enrollment] PRIMARY KEY CLUSTERED 
(
	[EnrollmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 21/11/2024 09.00.15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[HireDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OfficeAssignment]    Script Date: 21/11/2024 09.00.15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OfficeAssignment](
	[InstructorID] [int] NOT NULL,
	[Location] [nvarchar](50) NULL,
 CONSTRAINT [PK_OfficeAssignment] PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 21/11/2024 09.00.15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[EnrollmentDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Course] ([CourseID], [Title], [Credits], [DepartmentID]) VALUES (1045, N'Calculus', 4, 3)
INSERT [dbo].[Course] ([CourseID], [Title], [Credits], [DepartmentID]) VALUES (1050, N'Chemistry', 3, 2)
INSERT [dbo].[Course] ([CourseID], [Title], [Credits], [DepartmentID]) VALUES (2021, N'Composition', 3, 4)
INSERT [dbo].[Course] ([CourseID], [Title], [Credits], [DepartmentID]) VALUES (2042, N'Literature', 4, 4)
INSERT [dbo].[Course] ([CourseID], [Title], [Credits], [DepartmentID]) VALUES (3141, N'Trigonometry', 4, 3)
INSERT [dbo].[Course] ([CourseID], [Title], [Credits], [DepartmentID]) VALUES (4022, N'Microeconomics', 3, 1)
INSERT [dbo].[Course] ([CourseID], [Title], [Credits], [DepartmentID]) VALUES (4041, N'Macroeconomics', 3, 1)
GO
INSERT [dbo].[CourseAssignment] ([InstructorID], [CourseID]) VALUES (1, 4022)
INSERT [dbo].[CourseAssignment] ([InstructorID], [CourseID]) VALUES (1, 4041)
INSERT [dbo].[CourseAssignment] ([InstructorID], [CourseID]) VALUES (2, 1050)
INSERT [dbo].[CourseAssignment] ([InstructorID], [CourseID]) VALUES (3, 1050)
INSERT [dbo].[CourseAssignment] ([InstructorID], [CourseID]) VALUES (3, 3141)
INSERT [dbo].[CourseAssignment] ([InstructorID], [CourseID]) VALUES (4, 1045)
INSERT [dbo].[CourseAssignment] ([InstructorID], [CourseID]) VALUES (4, 2042)
INSERT [dbo].[CourseAssignment] ([InstructorID], [CourseID]) VALUES (4, 3141)
INSERT [dbo].[CourseAssignment] ([InstructorID], [CourseID]) VALUES (4, 4041)
INSERT [dbo].[CourseAssignment] ([InstructorID], [CourseID]) VALUES (5, 2021)
INSERT [dbo].[CourseAssignment] ([InstructorID], [CourseID]) VALUES (5, 2042)
GO
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([DepartmentID], [Name], [Budget], [StartDate], [InstructorID]) VALUES (1, N'Economics', 100000.0000, CAST(N'2007-09-01T00:00:00.0000000' AS DateTime2), 2)
INSERT [dbo].[Department] ([DepartmentID], [Name], [Budget], [StartDate], [InstructorID]) VALUES (2, N'Engineering', 350000.0000, CAST(N'2007-09-01T00:00:00.0000000' AS DateTime2), 3)
INSERT [dbo].[Department] ([DepartmentID], [Name], [Budget], [StartDate], [InstructorID]) VALUES (3, N'Mathematics', 100000.0000, CAST(N'2007-09-01T00:00:00.0000000' AS DateTime2), 4)
INSERT [dbo].[Department] ([DepartmentID], [Name], [Budget], [StartDate], [InstructorID]) VALUES (4, N'English', 350000.0000, CAST(N'2007-09-01T00:00:00.0000000' AS DateTime2), 5)
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
SET IDENTITY_INSERT [dbo].[Enrollment] ON 

INSERT [dbo].[Enrollment] ([EnrollmentID], [CourseID], [StudentID], [Grade]) VALUES (10, 2021, 5, 1)
SET IDENTITY_INSERT [dbo].[Enrollment] OFF
GO
SET IDENTITY_INSERT [dbo].[Instructor] ON 

INSERT [dbo].[Instructor] ([ID], [LastName], [FirstName], [HireDate]) VALUES (1, N'Zheng', N'Roger', CAST(N'2004-02-12T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Instructor] ([ID], [LastName], [FirstName], [HireDate]) VALUES (2, N'Kapoor', N'Candace', CAST(N'2001-01-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Instructor] ([ID], [LastName], [FirstName], [HireDate]) VALUES (3, N'Harui', N'Roger', CAST(N'1998-07-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Instructor] ([ID], [LastName], [FirstName], [HireDate]) VALUES (4, N'Fakhouri', N'Fadi', CAST(N'2002-07-06T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Instructor] ([ID], [LastName], [FirstName], [HireDate]) VALUES (5, N'Abercrombie', N'Kim', CAST(N'1995-03-11T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Instructor] OFF
GO
INSERT [dbo].[OfficeAssignment] ([InstructorID], [Location]) VALUES (2, N'Thompson 304')
INSERT [dbo].[OfficeAssignment] ([InstructorID], [Location]) VALUES (3, N'Gowan 27')
INSERT [dbo].[OfficeAssignment] ([InstructorID], [Location]) VALUES (4, N'Smith 17')
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (5, N'Li', N'Yan', CAST(N'2018-09-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (10, N'Kevin', N'b', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (11, N'Mernin', N'Henry', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (12, N'Greenstreet', N'Tabetha', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (13, N'Reinsmith', N'Grady', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (14, N'Bees', N'Willene', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (15, N'Guanche', N'Adina', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (16, N'Rullan', N'Rosann', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (17, N'Divento', N'Genevie', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (18, N'Riliford', N'Anjanette', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (19, N'Stauss', N'Fidel', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (20, N'Tristan', N'Felice', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (21, N'Lysak', N'Willodean', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (22, N'Satre', N'Fredrick', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (23, N'Ribaudo', N'Seth', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (24, N'Delemos', N'Arnoldo', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (25, N'Grohmann', N'Timmy', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (26, N'Skevofilakas', N'Emilio', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (27, N'Maclean', N'Joey', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (28, N'Chetram', N'Moses', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (29, N'Kirkconnell', N'Marisol', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (30, N'Gros', N'Antoine', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (31, N'Esquinaldo', N'Dena', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (32, N'Kuse', N'Ula', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (33, N'Fies', N'Floria', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (34, N'Indovina', N'Gabriele', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (35, N'Rogado', N'Catrina', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (36, N'Pamphile', N'Daria', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (37, N'Brasch', N'Camellia', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (38, N'Talmage', N'Janiece', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (39, N'Sessions', N'Nery', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (40, N'Marozzi', N'Berneice', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (41, N'Sawaia', N'Hugh', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (42, N'Petrillose', N'Senaida', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (43, N'Dochterman', N'Jeannie', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (44, N'Korchnak', N'Marcene', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (45, N'Tack', N'Oda', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (46, N'Kovacevic', N'Broderick', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (47, N'Pricer', N'Corey', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (48, N'Eidem', N'Elmira', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (49, N'Pridgen', N'Fletcher', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (50, N'Simkin', N'Consuela', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (51, N'Negroni', N'Kris', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (52, N'Glynn', N'Astrid', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (53, N'Brojakowski', N'Lonny', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (54, N'Lichtman', N'Edmund', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (55, N'Gregorich', N'Orville', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (56, N'Ruffcorn', N'Tad', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (57, N'Luebbe', N'Linwood', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (58, N'Rutenberg', N'Chantay', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (59, N'Herpolsheimer', N'Woodrow', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Student] ([ID], [LastName], [FirstName], [EnrollmentDate]) VALUES (60, N'Czachorowski', N'Wilfred', CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Department_DepartmentID] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Department_DepartmentID]
GO
ALTER TABLE [dbo].[CourseAssignment]  WITH CHECK ADD  CONSTRAINT [FK_CourseAssignment_Course_CourseID] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CourseAssignment] CHECK CONSTRAINT [FK_CourseAssignment_Course_CourseID]
GO
ALTER TABLE [dbo].[CourseAssignment]  WITH CHECK ADD  CONSTRAINT [FK_CourseAssignment_Instructor_InstructorID] FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CourseAssignment] CHECK CONSTRAINT [FK_CourseAssignment_Instructor_InstructorID]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Instructor_InstructorID] FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([ID])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_Instructor_InstructorID]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Course_CourseID] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_Course_CourseID]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Student_StudentID] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_Student_StudentID]
GO
ALTER TABLE [dbo].[OfficeAssignment]  WITH CHECK ADD  CONSTRAINT [FK_OfficeAssignment_Instructor_InstructorID] FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OfficeAssignment] CHECK CONSTRAINT [FK_OfficeAssignment_Instructor_InstructorID]
GO
