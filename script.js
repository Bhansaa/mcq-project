document.getElementById("login-form").addEventListener("submit", function(event) {
    event.preventDefault(); 
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    
    
    if (username === "admin" && password === "admin123") {
        alert("Login successful!");
        
    } else {
        alert("Login failed. Please check your credentials.");
    }
});