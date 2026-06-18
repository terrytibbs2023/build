const { jsPDF } = window.jspdf;

// --- MOBILE INTERACTION & NAVIGATION ---
const tabIntake = document.getElementById('tabIntake');
const tabAfterJob = document.getElementById('tabAfterJob');
const intakeForm = document.getElementById('repairForm');
const afterJobForm = document.getElementById('afterJobForm');

tabIntake.addEventListener('click', () => {
    tabIntake.classList.add('active');
    tabAfterJob.classList.remove('active');
    intakeForm.classList.add('active');
    afterJobForm.classList.remove('active');
});

tabAfterJob.addEventListener('click', () => {
    tabAfterJob.classList.add('active');
    tabIntake.classList.remove('active');
    afterJobForm.classList.add('active');
    intakeForm.classList.remove('active');
});

// --- AUTOMATIC INTAKE SYMPTOM INJECTION ---
const faultTags = document.getElementById('faultTags');
const issueTextarea = document.getElementById('issue');

if (faultTags) {
    faultTags.addEventListener('click', (e) => {
        if (e.target.classList.contains('tag-btn')) {
            const fault = e.target.getAttribute('data-fault');
            if (issueTextarea.value.includes(fault)) return;
            issueTextarea.value += (issueTextarea.value ? ', ' : '') + fault;
        }
    });
}

// --- PHOTO PROCESSING FOR REPORTING ---
let uploadedImagesBase64 = [];
const jobPhotosInput = document.getElementById('jobPhotos');
const photoPreviewContainer = document.getElementById('photoPreviewContainer');

jobPhotosInput.addEventListener('change', (e) => {
    photoPreviewContainer.innerHTML = '';
    uploadedImagesBase64 = [];
    const files = e.target.files;

    if (files) {
        Array.from(files).forEach(file => {
            const reader = new FileReader();
            reader.onload = (event) => {
                const base64String = event.target.result;
                uploadedImagesBase64.push(base64String);

                // Add phone preview block
                const img = document.createElement('img');
                img.src = base64String;
                photoPreviewContainer.appendChild(img);
            };
            reader.readAsDataURL(file);
        });
    }
});

// --- GENERATE INTAKE DOCUMENTATION ---
intakeForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const doc = new jsPDF();
    
    doc.setFont("helvetica", "bold");
    doc.setFontSize(20);
    doc.text("Essex Console Repair - Booking Intake", 15, 20);
    
    doc.setFontSize(12);
    doc.setFont("helvetica", "normal");
    doc.text(`Date: ${new Date().toLocaleDateString()}`, 15, 30);
    doc.text(`Taken In By: ${document.getElementById('takenInBy').value}`, 15, 40);
    doc.text(`Console: ${document.getElementById('consoleMake').value} - ${document.getElementById('consoleModel').value}`, 15, 50);
    
    doc.setFont("helvetica", "bold");
    doc.text("Reported Issues:", 15, 65);
    doc.setFont("helvetica", "normal");
    
    const splitIssue = doc.splitTextToSize(issueTextarea.value, 180);
    doc.text(splitIssue, 15, 75);
    
    doc.save(`Intake_${document.getElementById('consoleModel').value.replace(/\s+/g, '_')}.pdf`);
});

// --- GENERATE AFTER JOB RESOLUTION DOCUMENTATION ---
afterJobForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const doc = new jsPDF();

    const make = document.getElementById('jobConsoleMake').value;
    const model = document.getElementById('jobConsoleModel').value;
    const notes = document.getElementById('repairNotes').value;

    doc.setFont("helvetica", "bold");
    doc.setFontSize(20);
    doc.text("Essex Console Repair - Job Completion Report", 15, 20);

    doc.setFontSize(12);
    doc.setFont("helvetica", "normal");
    doc.text(`Date Completed: ${new Date().toLocaleDateString()}`, 15, 30);
    doc.text(`Device: ${make} - ${model}`, 15, 40);

    doc.setFont("helvetica", "bold");
    doc.text("Technical Repair Notes:", 15, 55);
    doc.setFont("helvetica", "normal");
    
    const splitNotes = doc.splitTextToSize(notes, 180);
    doc.text(splitNotes, 15, 65);

    let currentY = 65 + (splitNotes.length * 7) + 10; 

    if (uploadedImagesBase64.length > 0) {
        doc.setFont("helvetica", "bold");
        doc.text("Job Documentation Photos:", 15, currentY);
        currentY += 10;

        let xOffset = 15;
        const imgWidth = 80;
        const imgHeight = 60;

        uploadedImagesBase64.forEach((base64Img) => {
            if (xOffset + imgWidth > 195) {
                xOffset = 15;
                currentY += imgHeight + 10;
            }

            if (currentY + imgHeight > 280) {
                doc.addPage();
                currentY = 20;
                xOffset = 15;
            }

            try {
                doc.addImage(base64Img, 'JPEG', xOffset, currentY, imgWidth, imgHeight);
            } catch (err) {
                doc.addImage(base64Img, 'PNG', xOffset, currentY, imgWidth, imgHeight);
            }
            xOffset += imgWidth + 10; 
        });
    }

    doc.save(`Fixed_${model.replace(/\s+/g, '_')}.pdf`);
});
