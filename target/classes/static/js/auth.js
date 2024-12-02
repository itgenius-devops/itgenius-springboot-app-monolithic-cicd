
$(document).ready(function () {
    $("#loginForm").on("submit", function (event) {
        event.preventDefault();
        const username = $("#username").val();
        const password = $("#loginPassword").val();

        $.ajax({
            url: "/auth/login",
            type: "POST",
            data: {username: username, password: password},
            success: function (response) {
                // alert(response);
                window.location.href = "/welcome";
            },
            error: function (xhr) {
                if (xhr.status === 401) {
                    alert("Invalid credentials");
                }
            }
        });
    });


    $('#registerForm').on('submit', function(event) {
        event.preventDefault(); // Prevent the form from submitting the traditional way

        const formData = {
            username: $("input[name='usernameReg']").val(),
            password: $("input[name='passwordReg']").val(),
            fullName: $("input[name='fullName']").val()
        };

        $.ajax({
            type: 'POST',
            url: '/auth/registration', // URL of your controller method
            data: formData,
            success: function(response) {
                alert('Registration completed: ' + response);
            },
            error: function(xhr) {
                if (xhr.status === 208) {
                    alert('User already exists');
                } else {
                    alert('An error occurred: ' + xhr.responseText);
                }
            }
        });
    });



    // Check session when the page loads
    $.get("/auth/check-session", function (response) {
        if (response) {
            alert("You are already logged in!");
            // window.location.href = "/";
        }
    });
});

function logout() {
    // Assuming you have a logout endpoint mapped to your login controller

    $.post("/auth/logout", function (response) {
        if (response) {
            // alert("You are logged out!");
            window.location.href = "/";
        }
    });
    // window.location.href = '/auth/logout'; // Change this to your actual logout URL
}
