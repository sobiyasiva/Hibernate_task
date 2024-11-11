document.addEventListener("DOMContentLoaded", function() {
    setupValidation("addName");
    setupValidation("editName");
    setupValidation("addPhoneNumber");
    setupValidation("editPhoneNumber");
    setupWhitespaceValidation();
});

function setupValidation(inputId) {
    const input = document.getElementById(inputId);

    if (!input) return;  // Ensure the element exists

    input.addEventListener("input", function() {
        if (inputId === "addName" || inputId === "editName") {
            if (/\d/.test(input.value)) {
                showToast("Name cannot contain numbers.");
                input.value = input.value.replace(/\d/g, ''); 
            }
        } else if (inputId === "addPhoneNumber" || inputId === "editPhoneNumber") {
            if (/\D/.test(input.value)) {
                showToast("Phone number cannot contain letters and special characters.");
                input.value = input.value.replace(/\D/g, ''); 
            }
        }
    });
}

function setupWhitespaceValidation() {
    const inputFields = document.querySelectorAll("input[type='text'], input[type='email'], input[type='date']");
    inputFields.forEach(input => {
        input.addEventListener("input", function() {
            if (/^\s/.test(input.value)) {
                showToast("Input cannot start with whitespace.");
                input.value = input.value.trimStart();
            }
        });
    });
}

function openAddModal() {
    document.querySelector(".overlay").style.display = "block";
    document.getElementById("addCustomerModal").style.display = "block";
}

function closeModal() {
    document.querySelector(".overlay").style.display = "none";
    document.getElementById("addCustomerModal").style.display = "none";
    document.getElementById("editCustomerModal").style.display = "none";
}

function openEditModal(customerId, name, email, phoneNumber, address, dateOfBirth) {
    if (confirm('Are you sure you want to edit this customer?')) {
        document.querySelector(".overlay").style.display = "block";
        document.getElementById("editId").value = customerId;
        document.getElementById("editName").value = name;
        document.getElementById("editEmail").value = email;
        document.getElementById("editPhoneNumber").value = phoneNumber;
        document.getElementById("editAddress").value = address;
        document.getElementById("editDateOfBirth").value = dateOfBirth;
        document.getElementById("editCustomerModal").style.display = "block";
    }
}

function openDeleteModal(customerId) {
    if (confirm('Are you sure you want to delete this customer?')) {
        document.getElementById('deleteCustomerId').value = customerId;
        document.getElementById('deleteForm').submit();
    }
}

let currentToastMessage = null; 
let toastTimeout; 
let isToastVisible = false;

function showToast(message) {
    if (isToastVisible && message === currentToastMessage) return;
    const toastContainer = document.getElementById("toastContainer");
    if (toastTimeout) clearTimeout(toastTimeout);
    if (isToastVisible) {
        const previousToast = toastContainer.querySelector(".toast-message");
        if (previousToast) toastContainer.removeChild(previousToast);
    }
    const toastMessage = document.createElement("div");
    toastMessage.className = "toast-message";
    toastMessage.innerText = message;
    toastContainer.appendChild(toastMessage);
    isToastVisible = true;
    currentToastMessage = message;
    toastTimeout = setTimeout(() => {
        toastContainer.removeChild(toastMessage);
        isToastVisible = false;
        currentToastMessage = null;
    }, 3000);
}
