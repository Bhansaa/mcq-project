document.addEventListener("DOMContentLoaded", function() {
    const loginForm = document.getElementById("login-form");

    if (loginForm) {
        loginForm.addEventListener("submit", function(event) {
            event.preventDefault();
            const username = document.getElementById("username").value;
            const password = document.getElementById("password").value;
            
           
            loginUser(username, password);
        });
    }

    function loginUser(username, password) {
        
        setTimeout(function() {
            alert("Login successful!");
            
        }, 1000);
        
       
    }
});