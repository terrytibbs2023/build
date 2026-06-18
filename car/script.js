window.onload = () => {
  const { jsPDF } = window.jspdf;
  
  // Elements for Form 1 (Intake)
  const form = document.getElementById("repairForm");
  const takenInByInput = document.getElementById("takenInBy");
  const issueTextarea = document.getElementById("issue");
  const tagContainer = document.getElementById("faultTags");

  // Elements for Form 2 (After Job Report)
  const afterJobForm = document.getElementById("afterJobForm");
  const jobPhotosInput = document.getElementById("jobPhotos");
  const photoPreviewContainer = document.getElementById("photoPreviewContainer");

  // Elements for Mode Switcher Tabs
  const tabIntake = document.getElementById('tabIntake');
  const tabAfterJob = document.getElementById('tabAfterJob');

  // --- TAB SELECTION ENGINE ---
  if (tabIntake && tabAfterJob) {
    tabIntake.addEventListener('click', () => {
        tabIntake.classList.add('active');
        tabAfterJob.classList.remove('active');
        form.classList.add('active');
        afterJobForm.classList.remove('active');
    });

    tabAfterJob.addEventListener('click', () => {
        tabAfterJob.classList.add('active');
        tabIntake.classList.remove('active');
        afterJobForm.classList.add('active');
        form.classList.remove('active');
    });
  }

  // Load saved technician name from localStorage if available
  if (localStorage.getItem("ecr_techName") && takenInByInput) {
    takenInByInput.value = localStorage.getItem("ecr_techName");
  }

  // Quick-click tag logic - targets the textarea smoothly
  if (tagContainer) {
    tagContainer.addEventListener("click", (e) => {
      if (e.target.classList.contains("tag-btn")) {
        const faultText = e.target.getAttribute("data-fault");
        let currentText = issueTextarea.value.trim();
        
        if (currentText === "") {
          issueTextarea.value = faultText;
        } else if (!currentText.includes(faultText)) {
          issueTextarea.value = currentText + ", " + faultText;
        }
        issueTextarea.focus();
      }
    });
  }

  // --- MOBILE-SAFE FILE DOWNLOAD ENGINE ---
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

  // --- PROTO-IMAGE PIPELINE FOR AFTER JOB ---
  let uploadedImagesData = [];
  if (jobPhotosInput) {
    jobPhotosInput.addEventListener('change', (e) => {
        photoPreviewContainer.innerHTML = '';
        uploadedImagesData = [];
        const files = e.target.files;

        if (files) {
            Array.from(files).forEach(file => {
                const reader = new FileReader();
                reader.onload = (event) => {
                    const base64String = event.target.result;
                    const tempImg = new Image();
                    tempImg.onload = function() {
                        uploadedImagesData.push({
                            base64: base64String,
                            width: tempImg.width,
                            height: tempImg.height
                        });
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
  }

  // ==========================================
  // --- 1. YOUR ORIGINAL INTAKE RECEIPT ENGINE ---
  // ==========================================
  form.addEventListener("submit", function (e) {
    e.preventDefault();

    const takenInBy = takenInByInput.value.trim();
    const consoleMake = document.getElementById("consoleMake").value;
    const consoleModel = document.getElementById("consoleModel").value;
    const issue = issueTextarea.value.trim();

    // Save name for next layout
    localStorage.setItem("ecr_techName", takenInBy);

    // Job Number Engine: ecrDDMMYYHHmm
    const now = new Date();
    const day = String(now.getDate()).padStart(2, '0');
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const year = String(now.getFullYear()).slice(-2);
    const fullYear = now.getFullYear();
    const hour = String(now.getHours()).padStart(2, '0');
    const minute = String(now.getMinutes()).padStart(2, '0');
    const jobNumber = `ecr${day}${month}${year}${hour}${minute}`;
    const todayStr = `${day}/${month}/${fullYear}`;

    const doc = new jsPDF();
    const startY = 15; // Top alignment margin

    // Branding Header
    doc.setFont("Helvetica", "bold");
    doc.setFontSize(14);
    doc.setTextColor(2, 132, 199); // Sky blue brand color
    doc.text("Essex Console Repair", 10, startY);
    
    doc.setFontSize(10);
    doc.setFont("Helvetica", "normal");
    doc.setTextColor(80, 80, 80);
    doc.text("Orchard Business Units, Cockaynes Lane, Colchester, CO7 8BZ", 10, startY + 5);
    doc.text("Tel: 07935312274 | Web: essexconsolerepair.co.uk", 10, startY + 10);

    // Section Marker
    doc.setFont("Helvetica", "bold");
    doc.setFontSize(9);
    doc.setTextColor(120, 120, 120);
    doc.text("CUSTOMER RECEIPT", 155, startY);

    // Metadata Block Divider line
    doc.setDrawColor(200, 200, 200);
    doc.setLineWidth(0.5);
    doc.line(10, startY + 14, 200, startY + 14);

    // Metadata Grid details
    doc.setFontSize(11);
    doc.setTextColor(0, 0, 0);
    doc.setFont("Helvetica", "bold");
    doc.text(`Job Number:`, 10, startY + 21);
    doc.setFont("Helvetica", "normal");
    doc.text(jobNumber, 38, startY + 21);

    doc.setFont("Helvetica", "bold");
    doc.text(`Date Intake:`, 110, startY + 21);
    doc.setFont("Helvetica", "normal");
    doc.text(todayStr, 138, startY + 21);

    doc.setFont("Helvetica", "bold");
    doc.text(`Device Details:`, 10, startY + 28);
    doc.setFont("Helvetica", "normal");
    doc.text(`${consoleMake} - ${consoleModel}`, 42, startY + 28);

    doc.setFont("Helvetica", "bold");
    doc.text(`Booked In By:`, 110, startY + 28);
    doc.setFont("Helvetica", "normal");
    doc.text(takenInBy, 138, startY + 28);

    // Issue Container Block
    doc.setFont("Helvetica", "bold");
    doc.text("Reported Diagnostics / Faults Summary:", 10, startY + 38);
    
    doc.setDrawColor(220, 225, 230);
    doc.setFillColor(248, 250, 252);
    doc.rect(10, startY + 41, 190, 45, "FD");
    
    doc.setFont("Helvetica", "normal");
    doc.setFontSize(10);
    doc.setTextColor(30, 41, 59);
    doc.text(issue, 13, startY + 47, { maxWidth: 184 });

    // Instantly download the file safely on desktop + mobile web containers
    triggerMobileFriendlyDownload(doc, `Repair_Job_${jobNumber}.pdf`);

    // Dynamic UI Success Notification Pop
    let feedbackArea = document.getElementById("pdfPreviewContainer");
    if (!feedbackArea) {
      feedbackArea = document.createElement("div");
      feedbackArea.id = "pdfPreviewContainer";
      feedbackArea.style.marginTop = "20px";
      feedbackArea.style.textAlign = "center";
      form.parentNode.appendChild(feedbackArea);
    }

    feedbackArea.innerHTML = `
      <div style="background-color: #10b981; color: white; padding: 12px; border-radius: 8px; font-weight: bold; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
        ✅ Job Generated & Downloaded: ${jobNumber}
      </div>
    `;
    setTimeout(() => {
      feedbackArea.innerHTML = "";
    }, 4000);

    // Reset layout form options
    issueTextarea.value = "";
    document.getElementById("consoleMake").value = "";
    document.getElementById("consoleModel").value = "";
  });


  // ==========================================
  // --- 2. AFTER JOB COMPLETION RECEIPT ENGINE ---
  // ==========================================
  afterJobForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const doc = new jsPDF();
    const startY = 15;

    const make = document.getElementById('jobConsoleMake').value;
    const model = document.getElementById('jobConsoleModel').value;
    const notes = document.getElementById('repairNotes').value;

    const now = new Date();
    const day = String(now.getDate()).padStart(2, '0');
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const fullYear = now.getFullYear();
    const todayStr = `${day}/${month}/${fullYear}`;

    // Maintain matching brand styles
    doc.setFont("Helvetica", "bold");
    doc.setFontSize(14);
    doc.setTextColor(2, 132, 199); // Sky blue brand color
    doc.text("Essex Console Repair", 10, startY);
    
    doc.setFontSize(10);
    doc.setFont("Helvetica", "normal");
    doc.setTextColor(80, 80, 80);
    doc.text("Orchard Business Units, Cockaynes Lane, Colchester, CO7 8BZ", 10, startY + 5);
    doc.text("Tel: 07935312274 | Web: essexconsolerepair.co.uk", 10, startY + 10);

    doc.setFont("Helvetica", "bold");
    doc.setFontSize(9);
    doc.setTextColor(120, 120, 120);
    doc.text("JOB COMPLETION REPORT", 145, startY);

    doc.setDrawColor(200, 200, 200);
    doc.setLineWidth(0.5);
    doc.line(10, startY + 14, 200, startY + 14);

    doc.setFontSize(11);
    doc.setTextColor(0, 0, 0);
    doc.setFont("Helvetica", "bold");
    doc.text(`Date Completed:`, 10, startY + 21);
    doc.setFont("Helvetica", "normal");
    doc.text(todayStr, 42, startY + 21);

    doc.setFont("Helvetica", "bold");
    doc.text(`Device Details:`, 10, startY + 28);
    doc.setFont("Helvetica", "normal");
    doc.text(`${make} - ${model}`, 42, startY + 28);

    doc.setFont("Helvetica", "bold");
    doc.text("Technical Repair Notes & Work Carried Out:", 10, startY + 38);

    const splitNotes = doc.splitTextToSize(notes, 184);
    
    // Draw fluid size container box dynamically behind text to match layout specs
    const calculatedBoxHeight = Math.max(45, (splitNotes.length * 6) + 10);
    doc.setDrawColor(220, 225, 230);
    doc.setFillColor(248, 250, 252);
    doc.rect(10, startY + 41, 190, calculatedBoxHeight, "FD");

    doc.setFont("Helvetica", "normal");
    doc.setFontSize(10);
    doc.setTextColor(30, 41, 59);
    doc.text(splitNotes, 13, startY + 47);

    let currentY = startY + 41 + calculatedBoxHeight + 12;
    const targetWidthMM = 80;

    if (uploadedImagesData.length > 0) {
        doc.setFont("Helvetica", "bold");
        doc.setFontSize(11);
        doc.setTextColor(0, 0, 0);
        doc.text("Job Documentation Photos:", 10, currentY);
        currentY += 6;

        let xOffset = 10;
        let maxRowHeight = 0;

        uploadedImagesData.forEach((imageData) => {
            const aspectRatio = imageData.width / imageData.height;
            const dynamicHeightMM = targetWidthMM / aspectRatio;

            if (dynamicHeightMM > maxRowHeight) {
                maxRowHeight = dynamicHeightMM;
            }

            if (xOffset + targetWidthMM > 200) {
                xOffset = 10;
                currentY += maxRowHeight + 8;
                maxRowHeight = dynamicHeightMM;
            }

            if (currentY + dynamicHeightMM > 280) {
                doc.addPage();
                currentY = 20;
                xOffset = 10;
            }

            try {
                doc.addImage(imageData.base64, 'JPEG', xOffset, currentY, targetWidthMM, dynamicHeightMM);
            } catch (err) {
                doc.addImage(imageData.base64, 'PNG', xOffset, currentY, targetWidthMM, dynamicHeightMM);
            }

            xOffset += targetWidthMM + 8; 
        });
    }

    const cleanModelName = model.replace(/\s+/g, '_');
    triggerMobileFriendlyDownload(doc, `Fixed_${cleanModelName}.pdf`);

    // Reset After Job forms options cleanly after completion
    document.getElementById("repairNotes").value = "";
    document.getElementById("jobConsoleMake").value = "";
    document.getElementById("jobConsoleModel").value = "";
    photoPreviewContainer.innerHTML = "";
    uploadedImagesData = [];
  });
};
