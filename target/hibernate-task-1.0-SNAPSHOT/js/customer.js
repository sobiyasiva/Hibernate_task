document.addEventListener("DOMContentLoaded", function() {
        addNameValidation();
        EditaddNameValidation();       
        setupPhoneNumberValidation();       
        setupEditPhoneNumberValidation();       
        setupWhitespaceValidation();
        
    });   
    function startsWithWhitespace(value) {    
        return /^\s/.test(value);
    }    
    function setupPhoneNumberValidation() {
        const phoneNumberInput = document.getElementById("addPhoneNumber");
        phoneNumberInput.addEventListener("input", function() {
            if (/\D/.test(phoneNumberInput.value)) {
                showToast("Phone number cannot contain letters and special characters.");
                phoneNumberInput.value = phoneNumberInput.value.replace(/\D/g, ''); 
            }
        });
    }
    
    function addNameValidation() {
        const addNameInput = document.getElementById("addName");
        addNameInput.addEventListener("input", function() {
            if (/\d/.test(addNameInput.value)) { 
                showToast("Name cannot contain numbers.");
                addNameInput.value = addNameInput.value.replace(/\d/g, ''); 
            }
        });
    }    
    function EditaddNameValidation() {
        const editaddNameInput = document.getElementById("editName");
        if (!editaddNameInput.dataset.listenerAdded) { 
            editaddNameInput.addEventListener("input", function() {
                if (/\d/.test(editaddNameInput.value)) {
                    showToast("Name cannot contain numbers.");
                    editaddNameInput.value = editaddNameInput.value.replace(/\d/g, ''); 
                }
            });
            editaddNameInput.dataset.listenerAdded = true;  
        }
    }    
    function setupEditPhoneNumberValidation() {
        const editPhoneNumberInput = document.getElementById("editPhoneNumber");
        if (!editPhoneNumberInput.dataset.listenerAdded) {  
            editPhoneNumberInput.addEventListener("input", function() {
                if (/\D/.test(editPhoneNumberInput.value)) {
                    showToast("Phone number cannot contain letters and special characters.");
                    editPhoneNumberInput.value = editPhoneNumberInput.value.replace(/\D/g, ''); 
                }
            });
            editPhoneNumberInput.dataset.listenerAdded = true;  
        }
    }   
    function setupWhitespaceValidation() {
        const inputFields = document.querySelectorAll("input[type='text'], input[type='email'], input[type='date']");
        inputFields.forEach(input => {
            input.addEventListener("input", function() {
                if (startsWithWhitespace(input.value)) {
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
            setupEditPhoneNumberValidation();
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
    
    