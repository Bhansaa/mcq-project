document.getElementById("signup-form").addEventListener("submit", function (event) {
    event.preventDefault();


    const firstName = document.getElementById("first-name").value;
    const lastName = document.getElementById("last-name").value;
    const email = document.getElementById("email").value;
    const newPassword = document.getElementById("new-password").value;
    const confirmPassword = document.getElementById("confirm-password").value;


    if (newPassword !== confirmPassword) {
        alert("Passwords do not match. Please try again.");
        return;
    }


    const userData = {
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: newPassword
    };

    alert("Registration successful!\n\n" + JSON.stringify(userData, null, 2));
});