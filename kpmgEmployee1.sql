USE KpmgEmployee

--inner join
select * from Employee INNER JOIN EmpDept ON Employee.Id= EmpDept.EmpId where Employee.Name LIKE '%i'

--left outer
select * from Employee  LEFT OUTER JOIN EmpDept ON Employee.Id=EmpDept.EmpId 

--right outer
select * from Employee RIGHT OUTER JOIN EmpDept ON Employee.Id=EmpDept.EmpId

--full outer join
select * from Dept FULL OUTER JOIN Employee ON Dept.Id=Employee.Id

--transactions + stored procedure
USE KpmgEmployee
GO

Alter Procedure sp_InsertNewCustomer(@Name NVARCHAR(150), @Category NVARCHAR(50))
AS
BEGIN
BEGIN TRANSACTION T1

INSERT INTO [dbo].[Employee]
           ([Name]
           ,[Designation]
           ,[Salary])
     VALUES
           ('Anushree','Bussiness Analyst',55000)


INSERT INTO [dbo].[Employee]
           ([Name]
           ,[Designation]
           ,[Salary])
     VALUES
           ('Deepanshu','Mechanical Engineer',30000)
IF @@ERROR <> 0
    ROLLBACK Transaction T1

INSERT INTO [dbo].[Dept]
           ([Name]
           ,[Category])
     VALUES
           (@Name,@Category)

IF @@ERROR <> 0
    ROLLBACK Transaction T1

DECLARE @Deptid INT
SET @Deptid = @@Identity

COMMIT TRANSACTION T1
END

exec [dbo].[sp_InsertNewCustomer] 'Accounts' , 'Manager'
select top 2* from Employee order by id desc
select top 1* from Dept order by id desc

 --to delete duplicate values
delete Employee where [Name] = 'Anushree' OR [Name] = 'Deepanshu'







