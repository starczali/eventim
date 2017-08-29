function deleteUser(userId) {
    var url = "../users/deleteUser";
    $.ajax({
        url: url,
        type: "POST",
        data:{id:userId},
        dataType:"json",
        success: function() {
            $("#user-text").html("User Deleted successfully!");
            document.getElementById(userId).remove();
        },
        error: function(xhr) {
            if (xhr.status = 200) {
                $("#user-text").html("User deleted!");
                document.getElementById(userId).remove();
            }
            else {
                $("#user-text").html("User delete encountered a problem!");
            }
            $('#myModal').modal('show');
        }
    });
}

function updateUser(userId) {
    console.log("userid="+userId);
    var url = "../users/updateUsers";
    $.ajax({
        url: url,
        type: "POST",
        data:$("#form"+userId).serialize(),
        dataType:"json",
        success: function() {
            $("#user-text").html("User Updated!");
        },
        error: function(xhr) {
            if (xhr.status = 200) {
                $("#user-text").html("User updated !");
            }
            else {
                $("#user-text").html("User update encountered a problem!");
            }
            $('#myModal').modal('show');
        }
    });
}

function redir(url){
    window.location.replace(url);
}