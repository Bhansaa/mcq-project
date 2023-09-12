document.addEventListener("DOMContentLoaded", function() {
    const signupForm = document.getElementById("signup-form");

    if (signupForm) {
        signupForm.addEventListener("submit", function(event) {
            event.preventDefault();
            const username = document.getElementById("username").value;
            const password = document.getElementById("password").value;
            
            
            registerUser(username, password);
        });
    }

    function registerUser(username, password) {
        
        
        setTimeout(function() {
            alert("Registration successful!");
            
        }, 1000);
        
        
    }
});