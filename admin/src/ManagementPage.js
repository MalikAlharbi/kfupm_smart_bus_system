import React from "react";
import "./ManagementPage.css";
import { FaHeadset, FaClipboardList } from "react-icons/fa"; // Import only used icons
import { useNavigate } from "react-router-dom";

function ManagementPage() {
  const navigate = useNavigate(); // Initialize navigation hook

  return (
    <div className="management-container">
      <div className="management-header">
        <h1 className="management-title">Bus Management</h1>
      </div>
      <div className="button-container">
        <button
          className="management-button"
          onClick={() => navigate("/support")} // Navigate to SupportPage
        >
          <FaHeadset className="button-icon" />
          Support
        </button>
        <button
          className="management-button"
          onClick={() => navigate("/user-info")} // Navigate to UserInfoPage
        >
          <FaClipboardList className="button-icon" />
          Bus Requests
        </button>
      </div>
    </div>
  );
}

export default ManagementPage;
