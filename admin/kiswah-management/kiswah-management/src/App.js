import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import ManagementPage from "./ManagementPage";
import SupportPage from "./SupportPage";
import UserInfoPage from "./BusRequestsPage"; // Import UserInfoPage

function App() {
  return (
    <Router>
      <Routes>
        {/* Default route for ManagementPage */}
        <Route path="/" element={<ManagementPage />} />
        
        {/* Route for SupportPage */}
        <Route path="/support" element={<SupportPage />} />
        
        {/* Route for UserInfoPage */}
        <Route path="/user-info" element={<UserInfoPage />} />
      </Routes>
    </Router>
  );
}

export default App;
