create database  as5
use as5
go
create table users (
id_user int primary key,
name_user varchar(50),
date_birth date,
address varchar(50)
)
INSERT INTO users (id_user, name_user, date_birth,address)
VALUES (1, 'thinh1', '19980822','hanoi1'),
		(2, 'thinh2', '19980830','hanoi2'),
		(3, 'thinh3', '19980812','hanoi3'),
		(4, 'thinh4', '19980822','hanoi4')
		INSERT INTO users (id_user, name_user, date_birth,address)
VALUES (9, 'thinh9', '19981122','hanoi1')
create table sdt(
id_sdt int primary key,
id_user int ,
sdts varchar(50)
 CONSTRAINT fk1
 FOREIGN KEY (id_user)
 REFERENCES users (id_user)
)

INSERT INTO sdt (id_sdt,id_user,sdts)
VALUES (101,1,'0968668871')
INSERT INTO sdt (id_sdt,id_user,sdts)
VALUES (102,1,'0968668872'),
		(103,1,'0968668873'),
		(104,2,'0968668874'),
		(105,2,'0968668875'),
		(106,3,'0968668876'),
		(107,3,'0968668877'),
		(108,4,'0968668878'),
		(109,4,'0968668879')
----4 Viết các câu lênh truy vấn để
---a) Liệt kê danh sách những người trong danh bạ
------b) Liệt kê danh sách số điện thoại có trong danh bạ
SELECT name_user FROM users
SELECT sdts FROM sdt
-----------Viết các câu lệnh truy vấn để lấy
----a) Liệt kê danh sách người trong danh bạ theo thứ thự alphabet.
----b) Liệt kê các số điện thoại của người có thên là Nguyễn Văn An.
-----c) Liệt kê những người có ngày sinh là 12/12/09
SELECT name_user   FROM users ORDER BY name_user ASC
SELECT sdts   FROM users JOIN sdt on sdt.id_user=users.id_user where name_user='thinh1'
SELECT name_user   FROM users where date_birth='19980812'
-----Viết các câu lệnh truy vấn để
----a) Tìm số lượng số điện thoại của mỗi người trong danh bạ.
-----b) Tìm tổng số người trong danh bạ sinh vào thang 12.
----c) Hiển thị toàn bộ thông tin về người, của từng số điện thoại.
-----d) Hiển thị toàn bộ thông tin về người, của số điện thoại 123456789.
select name_user, count(sdt.sdts)as total  FROM users JOIN sdt on sdt.id_user=users.id_user  
group by name_user
select count(distinct id_user) as totals 
 FROM users   where month(date_birth)='08'
select * from users

select sdt.sdts, users.id_user, users.name_user, users.date_birth,users.address 
FROM users JOIN sdt on sdt.id_user=users.id_user  
select sdt.sdts, users.id_user, users.name_user, users.date_birth,users.address 
FROM users JOIN sdt on sdt.id_user=users.id_user and  sdt.sdts=0968668872
----Thay đổi những thư sau từ cơ sở dữ liệu
------a) Viết câu lệnh để thay đổi trường ngày sinh là trước ngày hiện tại.
--------b) Viết câu lệnh để xác định các trường khóa chính và khóa ngoại của các bảng.
---------c) Viết câu lệnh để thêm trường ngày bắt đầu liên lạc.
ALTER TABLE users
ADD CONSTRAINT PK_Person check(date_birth<=getdate())
ALTER TABLE users
  ADD start_date date


-------  8 Thực hiện các yêu cầu sau
------a) Thực hiện các chỉ mục sau(Index)

-------◦ IX_HoTen : đặt chỉ mục cho cột Họ và tên
-------◦ IX_SoDienThoai: đặt chỉ mục cho cột Số điện thoại
-------b) Viết các View sau:
-----◦ View_SoDienThoai: hiển thị các thông tin gồm Họ tên, Số điện thoại
-----◦ View_SinhNhat: Hiển thị những người có sinh nhật trong tháng hiện tại (Họ tên, Ngày
-------sinh, Số điện thoại)
-------c) Viết các Store Procedure sau:
-----◦ SP_Them_DanhBa: Thêm một người mới vào danh bạn
-------◦ SP_Tim_DanhBa: Tìm thông tin liên hệ của một người theo tên (gần đúng)
CREATE INDEX indexhoten
ON users (name_user);
CREATE INDEX IX_SoDienThoai
ON sdt (sdts);
CREATE VIEW View_SoDienThoai1 AS
SELECT name_user, sdts
FROM users,sdt
where users.id_user=sdt.id_user
CREATE VIEW View_SinhNhat AS
SELECT name_user, sdts,date_birth
FROM users,sdt
where users.id_user=sdt.id_user and (month(getdate())-month(date_birth))=1
select * from View_SoDienThoai1



CREATE PROCEDURE SP_Them_DanhB 
(@Them_ID int,
@Them_DanhBa VARCHAR(50)) as declare @cou int 
INSERT INTO sdt (id_sdt,sdts)
VALUES (@Them_ID,@Them_DanhBa)
execute SP_Them_DanhB 10, '9090909' 
select *from sdt

CREATE PROCEDURE SP_Tim_DanhB 
@Them_Nmae VARCHAR(50) as 
select users.name_user,sdt.sdts,users.id_user from sdt,users where users.id_user=sdt.id_user and users.name_user=@Them_Nmae
execute SP_Tim_DanhB  'Thinh1' 