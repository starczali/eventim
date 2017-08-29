<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: info
  Date: 10.08.2017
  Time: 09:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="../../resources/js/user.js"></script>
<h3 class="col-md-offset-4">Update Users</h3>
<div class="col-sm-6 offset3">
    <c:if test="${not empty message}">
        <label>${message}</label><br>
    </c:if>
    <table class="table-bordered table-responsive">
        <c:forEach items="${users}" var="user">
            <tr>
                <form method="POST" id="form${user.id}">
                    <div class="form-control">
                        <label class="col-sm-3">ID:${user.id}</label><br>
                        <input class="col-sm-9" type="hidden" name="id" value="${user.id}"/>
                    </div>
                    <div class="form-control">
                        <label class="col-sm-3">Username:</label>
                        <input class="col-sm-9" name="name"  value="${user.name}"/>
                    </div>
                    <div class="form-control">
                        <label class="col-sm-3">Password:</label>
                        <input name="password" type="password" class="col-sm-9" value="${user.password}"/>
                    </div>
                    <div class="form-control">
                        <label class="col-sm-3">Email:</label>
                        <input class="col-sm-9" name="email" value="${user.email}"/>
                    </div>
                    <div class="form-control">
                        <label class="col-sm-3">Type:</label>
                        <div class="col-sm-9">
                            <label class="radio-inline">
                                <input class="radio-button radio-inline" type="radio" name="type" value="ADMIN"> Administrator<br>
                            </label>
                            <label class="radio-inline">
                                <input class="radio-button radio-inline" type="radio" name="type" value="NORMAL" checked> User<br>
                            </label>
                        </div>
                    </div>
                    <input type="button" class="btn btn-success col-xs-3" value="Save" onclick="updateUser(${user.id})"/>
                    <br><br>
                </form>
            </tr>
        </c:forEach>
    </table>


    <!-- Modal -->
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Success</h4>
                </div>
                <div class="modal-body">
                    <p id="user-text"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="redir('../users/updateUsers')" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
</div>