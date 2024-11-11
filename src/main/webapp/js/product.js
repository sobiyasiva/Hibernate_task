document.addEventListener("DOMContentLoaded", function() {
    setupNameValidation("addName");
    setupPriceValidation("addPrice");
    setupNameValidation("editName");
    setupPriceValidation("editPrice");
    setupWhitespaceValidation();
});

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
function setupNameValidation(inputId) {
    const nameInput = document.getElementById(inputId);
    nameInput.addEventListener("input", function() {
        if (/\d/.test(nameInput.value)) { 
            showToast("Name cannot contain numbers.");
            nameInput.value = nameInput.value.replace(/\d/g, ''); 
        }
    });
}

function setupPriceValidation(inputId) {
    const priceInput = document.getElementById(inputId);
    priceInput.addEventListener("input", function() {
        if (/\D/.test(priceInput.value)) { 
            showToast("Please enter only numeric characters in the price.");
            priceInput.value = priceInput.value.replace(/\D/g, ''); 
        }
    });
}

function setupWhitespaceValidation() {
    const inputFields = document.querySelectorAll("input[type='text']");
    inputFields.forEach(input => {
        input.addEventListener("input", function() {
            if (/^\s/.test(input.value)) {
                showToast("Input cannot start with whitespace.");
                input.value = input.value.trimStart();
            }
        });
    });
}

function openAddModal(){
    document.querySelector(".overlay").style.display = "block";
    document.getElementById("addProductModal").style.display = "block";
}

function closeModal() {
    document.querySelector(".overlay").style.display = "none";
    document.getElementById("addProductModal").style.display = "none";
    document.getElementById("editProductModal").style.display = "none";
}

function openEditModal(productId, name, price) {
    if (confirm('Are you sure you want to edit this product?')) {
        document.querySelector(".overlay").style.display = "block";
        document.getElementById("editId").value = productId;
        document.getElementById("editName").value = name;
        document.getElementById("editPrice").value = price;
        document.getElementById("editProductModal").style.display = "block";
    }
}
