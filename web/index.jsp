<%-- 
    Document   : index
    Created on : 22 Jan, 2022, 8:56:01 AM
    Author     : Akjan
--%>

<%@ page import="java.sql.*" %>
<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment", "root", "");
    PreparedStatement st;
    Statement statement;
    ResultSet resultset;
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <title>Student List</title>
    </head>
    <body>
        
        <!-- --------------------- Insert operation on student ---------------------- -->
        
        <%
            if (request.getParameter("Insert") != null) {
                statement = connection.createStatement();
                resultset = statement.executeQuery("select * from student where STUDENT_NO = " + request.getParameter("no"));
                if (resultset.next()) {
        %>
        <div class="alert alert-warning alert-dismissible fade show m-3" style="position: absolute;top:0;right:0;" role="alert">
            <strong>Alert</strong> inputed student no already exists !
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%
        } else {
            st = connection.prepareStatement("insert into student (STUDENT_NO,STUDENT_NAME,STUDENT_DOB,STUDENT_DOJ)values(?,?,?,?)");
            st.setInt(1, Integer.parseInt(request.getParameter("no")));
            st.setString(2, request.getParameter("name"));
            st.setString(3, request.getParameter("dob"));
            st.setString(4, request.getParameter("doj"));
            int i = st.executeUpdate();
            if (i >= 1) {%>
        <div class="alert alert-success alert-dismissible fade show m-3" style="position: absolute;top:0;right:0;" role="alert">
            <strong>Success</strong> Data Inserted Successfully !
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%}
                }
            }
        %>
        
        <!-- --------------------- Update operation on student ---------------------- -->
        
        <%
            if (request.getParameter("Update") != null)
            {
                st = connection.prepareStatement("update student set STUDENT_NAME = ?,STUDENT_DOB = ?,STUDENT_DOJ = ? where STUDENT_NO = ?");
                st.setInt(4, Integer.parseInt(request.getParameter("no")));
                st.setString(1, request.getParameter("name"));
                st.setString(2, request.getParameter("dob"));
                st.setString(3, request.getParameter("doj"));
                int i = st.executeUpdate();
                if (i >= 1) {%>
        <div class="alert alert-success alert-dismissible fade show m-3" style="position: absolute;top:0;right:0;" role="alert">
            <strong>Success</strong> Data Updated Successfully !
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%      }
            }
        %>
        
        <h1 class="container p-4 px-0">> Students Panel <span id="cursor" style="font-size: 3rem;">_</span></h1>
        <div class="container shadow-lg p-5 mb-5">
            <form method="post">
                <% if (request.getParameter("update") != null) {
                        statement = connection.createStatement();
                        resultset = statement.executeQuery("select * from student where STUDENT_NO = " + request.getParameter("id"));
                        resultset.next();
                %>
                <table class="container">
                    <tr class="row">
                        <th class="col-md-1">
                            No
                            <input type="number" class="form-control" name="no" min="1" max="999" value="<%= request.getParameter("id")%>" readonly required/>
                        </th>
                        <th class="col-md-3">
                            Name
                            <input type="text" class="form-control" name="name" value="<%= resultset.getString("STUDENT_NAME")%>" required/>
                        </th>
                        <th class="col-md-3">
                            DOB
                            <input type="date" class="form-control" name="dob" value="<%= resultset.getString("STUDENT_DOB")%>" required/>
                        </th>
                        <th class="col-md-3">
                            DOJ
                            <input type="date" class="form-control" name="doj" value="<%= resultset.getString("STUDENT_DOJ")%>" required/>
                        </th>
                        <th class="col-md-2">
                            <br/>
                            <input type="submit" class="btn btn-dark" name="Update" value="Update" />
                            <a href="./" class="btn btn-dark">Cancel</a>
                        </th>
                    </tr>
                </table>
                <%} else {
                    if (request.getParameter("delete") != null) {
                        statement = connection.createStatement();
                        int i = statement.executeUpdate("delete from student where STUDENT_NO = " + request.getParameter("id"));
                        if (i == 1) {
                %>
                <div class="alert alert-success alert-dismissible fade show m-3" style="position: absolute;top:0;right:0;" role="alert">
                    <strong>Yeah</strong> Data Deleted Successfully !
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                        }
                    }
                %>
                <table class="container">
                    <tr class="row">
                        <th class="col-md-2">
                            No
                            <input type="number" class="form-control" name="no" min="1" max="999" required/>
                        </th>
                        <th class="col-md-3">
                            Name
                            <input type="text" class="form-control" name="name" required/>
                        </th>
                        <th class="col-md-3">
                            DOB
                            <input type="date" class="form-control" name="dob" required/>
                        </th>
                        <th class="col-md-3">
                            DOJ
                            <input type="date" class="form-control" name="doj" required/>
                        </th>
                        <th class="col-md-1">
                            <br/>
                            <input type="submit" class="btn btn-dark" name="Insert" value="Insert" />
                        </th>
                    </tr>
                </table>
                <%}%>
            </form>
            <div class="my-5"></div>
            <table class="table">
                <thead>
                    <tr>
                        <th class="col-md-1">No</th>
                        <th class="col-md-5">Name</th>
                        <th class="col-md-2">DOB</th>
                        <th class="col-md-2">DOJ</th>
                        <th class="col-md-2">Action</th>
                    </tr>
                </thead>
                <%
                    statement = connection.createStatement();
                    resultset = statement.executeQuery("select * from student");
                %>
                <tbody>
                    <% while (resultset.next()) {%>
                    <tr>
                        <th scope="row"><%= resultset.getInt(1)%></th>
                        <td><%= resultset.getString(2)%></td>
                        <td><%= resultset.getString(3)%></td>
                        <td><%= resultset.getString(4)%></td>
                        <td class="col-md-2">
                            <div class="row">
                                <form method="post" class="col-md-6">
                                    <input type="hidden" value="<%= resultset.getInt(1)%>" name="id"/>
                                    <input type="submit" class="btn btn-dark btn-sm" value="Update" name="update"/>
                                </form>
                                <form method="post" class="col-md-6 text-end">
                                    <input type="hidden" value="<%= resultset.getInt(1)%>" name="id"/>
                                    <input type="submit" class="btn btn-dark btn-sm" value="Delete" name="delete"/>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
    </body>
    <script>
        var cursor = true;
        var speed = 250;
        setInterval(() => {
          if(cursor) {
            document.getElementById('cursor').style.opacity = 0;
            cursor = false;
          }else {
            document.getElementById('cursor').style.opacity = 1;
            cursor = true;
          }
        }, speed);
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</html>
