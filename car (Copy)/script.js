window.onload = () => {
  const { jsPDF } = window.jspdf;
  const form = document.getElementById("repairForm");
  const takenInByInput = document.getElementById("takenInBy");
  const issueTextarea = document.getElementById("issue");
  const tagContainer = document.getElementById("faultTags");

  // Load saved technician name from localStorage if available
  if (localStorage.getItem("ecr_techName")) {
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

    // Instantly download the file to the system storage
    doc.save(`Repair_Job_${jobNumber}.pdf`);

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
};
