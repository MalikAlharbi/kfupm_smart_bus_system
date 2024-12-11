import React, { useEffect, useState, useCallback } from "react";
import "./SupportPage.css"; // Your provided CSS
import { FaHeadset } from "react-icons/fa"; // Import the FaHeadset icon
import { collection, getDocs } from "firebase/firestore"; // Firebase Firestore functions
import { db } from "./firebase"; // Firebase configuration

function ReportProblemPage() {
  const [problems, setProblems] = useState([]);
  const [loading, setLoading] = useState(true);

  // Fetch problems from the 'report_problem' collection and sort them by timestamp
  const fetchProblems = useCallback(async () => {
    try {
      setLoading(true); // Show loading spinner
      const querySnapshot = await getDocs(collection(db, "report_problem"));
      const fetchedProblems = querySnapshot.docs.map((doc) => {
        const problemData = doc.data();
        return {
          id: doc.id, // Document UID
          ...problemData, // Include all fields from Firestore
          timestamp: problemData.timestamp?.toDate?.() || null, // Convert Firestore timestamp
        };
      });

      // Sort problems by timestamp (oldest first)
      fetchedProblems.sort((a, b) => (a.timestamp || 0) - (b.timestamp || 0));

      setProblems(fetchedProblems); // Update state with sorted problems
    } catch (error) {
      console.error("Error fetching problems:", error);
    } finally {
      setLoading(false); // Hide loading spinner
    }
  }, []);

  useEffect(() => {
    fetchProblems(); // Fetch problems on component mount
  }, [fetchProblems]);

  // Format the timestamp into a readable format
  const formatDate = (date) => {
    if (!date) return "No Date Provided";
    return (
      new Date(date).toLocaleDateString("en-GB", {
        day: "2-digit",
        month: "2-digit",
        year: "numeric",
      }) +
      " at " +
      new Date(date).toLocaleTimeString("en-US", {
        hour: "2-digit",
        minute: "2-digit",
        hour12: true,
      })
    );
  };

  return (
    <div className="support-page">
      <button onClick={() => window.history.back()} className="back-button">
        Back to Home
      </button>
      <div className="support-header">
        <FaHeadset className="support-icon" /> {/* Add the support icon */}
        <h1 className="support-title">Reported Problems</h1>
      </div>

      {loading ? (
        <div className="loading-container">
          <div className="spinner"></div>
          <p>Loading reported problems...</p>
        </div>
      ) : (
        <div className="table-wrapper">
          <table className="tickets-table">
            <thead>
              <tr>
                <th>#</th>
                <th>UID</th>
                <th>Bus Number</th>
                <th>Problem Description</th>
                <th>Problem Type</th>
                <th>Timestamp</th>
              </tr>
            </thead>
            <tbody>
              {problems.map((problem, index) => (
                <tr key={problem.id} className={index % 2 === 0 ? "even-row" : "odd-row"}>
                  <td>{index + 1}</td>
                  <td>{problem.id}</td>
                  <td>{problem.busNumber || "N/A"}</td>
                  <td>{problem.problemDescription || "N/A"}</td>
                  <td>{problem.problemType || "N/A"}</td>
                  <td>{formatDate(problem.timestamp)}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}

export default ReportProblemPage;
