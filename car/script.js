const { jsPDF } = window.jspdf;

// --- TAB SELECTION ENGINE (UNCHANGED) ---
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

// --- FORCE IMMUTABLE UK DATE STRINGS (UNCHANGED) ---
function getUKDate() {
    const date = new Date();
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const year = date.getFullYear();
    return `${day}/${month}/${year}`;
}

// --- SECURE DOWNLOAD CONTROLLER FOR MOBILE BROWSERS (UNCHANGED) ---
function triggerMobileFriendlyDownload(pdfDoc, filename) {
    try {
        pdfDoc.save(filename);
    } catch (e) {
        const blob = pdfDoc.output('blob');
        const blobUrl = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = blobUrl;
        link.download = filename;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        URL.revokeObjectURL(blobUrl);
    }
}

// --- SYMPTOM GENERATOR INTAKE SHORTCUTS (UNCHANGED) ---
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

// --- IMAGE PIPELINE LOGIC (UNCHANGED) ---
// This part handles the photo preview on the screen (the HTML grid)
let uploadedImagesData = []; // Store base64 AND original dimensions
const jobPhotosInput = document.getElementById('jobPhotos');
const photoPreviewContainer = document.getElementById('photoPreviewContainer');

jobPhotosInput.addEventListener('change', (e) => {
    photoPreviewContainer.innerHTML = '';
    uploadedImagesData = [];
    const files = e.target.files;

    if (files) {
        Array.from(files).forEach(file => {
            const reader = new FileReader();
            reader.onload = (event) => {
                const base64String = event.target.result;

                // Load image into a temporary JS Image object to get dimensions
                const tempImg = new Image();
                tempImg.onload = function() {
                    uploadedImagesData.push({
                        base64: base64String,
                        width: tempImg.width,   // Original Pixel Width
                        height: tempImg.height  // Original Pixel Height
                    });

                    // Add phone preview block (CSS already handles aspect ratio here)
                    const imgPreview = document.createElement('img');
                    imgPreview.src = base64String;
                    photoPreviewContainer.appendChild(imgPreview);
                };
                tempImg.src = base64String;
            };
            reader.readAsDataURL(file);
        });
    }
});

// --- INTAKE FORM GENERATION (UNCHANGED) ---
intakeForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const doc = new jsPDF();
    
    doc.setFont("helvetica", "bold");
    doc.setFontSize(20);
    doc.text("Essex Console Repair - Booking Intake", 15, 20);
    
    doc.setFontSize(12);
    doc.setFont("helvetica", "normal");
    doc.text(`Date: ${getUKDate()}`, 15, 30);
    doc.text(`Taken In By: ${document.getElementById('takenInBy').value}`, 15, 40);
    doc.text(`Console: ${document.getElementById('consoleMake').value} - ${document.getElementById('consoleModel').value}`, 15, 50);
    
    doc.setFont("helvetica", "bold");
    doc.text("Reported Issues:", 15, 65);
    doc.setFont("helvetica", "normal");
    
    const splitIssue = doc.splitTextToSize(issueTextarea.value, 180);
    doc.text(splitIssue, 15, 75);
    
    const cleanModelName = document.getElementById('consoleModel').value.replace(/\s+/g, '_');
    triggerMobileFriendlyDownload(doc, `Intake_${cleanModelName}.pdf`);
});

// --- AFTER JOB REPORT GENERATION (UPDATED FOR ASPECT RATIO) ---
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
    doc.text(`Date Completed: ${getUKDate()}`, 15, 30);
    doc.text(`Device: ${make} - ${model}`, 15, 40);

    doc.setFont("helvetica", "bold");
    doc.text("Technical Repair Notes:", 15, 55);
    doc.setFont("helvetica", "normal");
    
    const splitNotes = doc.splitTextToSize(notes, 180);
    doc.text(splitNotes, 15, 65);

    // Initial Y position for images (adjust based on note length)
    let currentY = 65 + (splitNotes.length * 7) + 10; 

    // Target width for photos (mm) in the PDF grid
    const targetWidthMM = 80;

    if (uploadedImagesData.length > 0) {
        doc.setFont("helvetica", "bold");
        doc.text("Job Documentation Photos:", 15, currentY);
        currentY += 10;

        let xOffset = 15;
        let maxRowHeight = 0; // Keep track of the tallest image in the current row

        uploadedImagesData.forEach((imageData) => {
            // --- ASPECT RATIO CALCULATION ---
            // Calculate the height needed to maintain the original aspect ratio
            const aspectRatio = imageData.width / imageData.height;
            const dynamicHeightMM = targetWidthMM / aspectRatio;

            // Update maxRowHeight if this image is the tallest in the row so far
            if (dynamicHeightMM > maxRowHeight) {
                maxRowHeight = dynamicHeightMM;
            }

            // --- PAGE/ROW FLOW LOGIC ---
            // 1. Row Overflow Check: If this image exceeds the right page margin (195mm baseline), start a new row
            if (xOffset + targetWidthMM > 195) {
                xOffset = 15; // Reset X to the left margin
                currentY += maxRowHeight + 10; // Move Y down by the tallest image height + padding
                maxRowHeight = 0; // Reset maxRowHeight for the new row

                // Recalculate dynamicHeightMM again as maxRowHeight was reset
                const freshAspectRatio = imageData.width / imageData.height;
                maxRowHeight = targetWidthMM / freshAspectRatio;
            }

            // 2. Page Overflow Check: If this image exceeds the bottom page margin (280mm baseline), add a new page
            // We use currentY + dynamicHeightMM to be precise
            if (currentY + dynamicHeightMM > 280) {
                doc.addPage();
                currentY = 20; // Reset Y near the top of the new page
                xOffset = 15; // Reset X to the left margin
            }

            // --- IMAGE INSERTION ---
            try {
                // Use JPEG format by default, fallback later if needed
                doc.addImage(imageData.base64, 'JPEG', xOffset, currentY, targetWidthMM, dynamicHeightMM);
            } catch (err) {
                // Fallback for PNG/Other formats if JPEG conversion failed
                doc.addImage(imageData.base64, 'PNG', xOffset, currentY, targetWidthMM, dynamicHeightMM);
            }

            // --- UPDATE POSITION FOR NEXT IMAGE ---
            xOffset += targetWidthMM + 10; // Move X right by the image width + padding
        });
    }

    const cleanModelName = model.replace(/\s+/g, '_');
    triggerMobileFriendlyDownload(doc, `Fixed_${cleanModelName}.pdf`);
});
