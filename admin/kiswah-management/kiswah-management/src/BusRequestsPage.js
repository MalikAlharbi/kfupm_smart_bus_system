import React, { useEffect, useState } from "react";
import "./BusRequestsPage.css"; // Using your provided CSS
import { FaClipboardList } from "react-icons/fa"; // Icon for the title
import { collection, getDocs, doc, updateDoc } from "firebase/firestore"; // Firebase Firestore functions
import { db } from "./firebase"; // Firebase configuration

function BusRequestsPage() {
  const [requests, setRequests] = useState([]);
  const [loading, setLoading] = useState(true);

  // Fetch the data from the "Event" collection in Firestore
  const fetchRequests = async () => {
    try {
      setLoading(true); // Show loading spinner
      const querySnapshot = await getDocs(collection(db, "Event"));
      const fetchedRequests = querySnapshot.docs.map((doc) => ({
        id: doc.id, // Document UID
        ...doc.data(), // Document data fields
      }));

      // Sort requests by status: In Process > Approved > Rejected
      const sortedRequests = [
        ...fetchedRequests.filter((req) => req.status === "In Process"),
        ...fetchedRequests.filter((req) => req.status === "Approved"),
        ...fetchedRequests.filter((req) => req.status === "Rejected"),
      ];

      setRequests(sortedRequests); // Update state with sorted requests
    } catch (error) {
      console.error("Error fetching requests:", error);
    } finally {
      setLoading(false); // Hide loading spinner
    }
  };

  // Update the status of a request in Firestore
  const updateRequestStatus = async (id, newStatus) => {
    try {
      const requestRef = doc(db, "Event", id); // Reference to the specific document
      await updateDoc(requestRef, { status: newStatus }); // Update the status field
      alert(`Request has been marked as ${newStatus}.`);
      fetchRequests(); // Refresh the data after updating
    } catch (error) {
      console.error("Error updating request status:", error);
      alert("Failed to update the request status.");
    }
  };

  useEffect(() => {
    fetchRequests(); // Fetch data on component mount
  }, []);

  const formatDate = (date) => {
    if (!date) return "No Date Provided";
    return new Date(date).toLocaleDateString("en-GB", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
    }) +
      " at " +
      new Date(date).toLocaleTimeString("en-US", {
        hour: "2-digit",
        minute: "2-digit",
        hour12: true,
      });
  };

  return (
    <div className="bus-requests-page">
      <button onClick={() => window.history.back()} className="back-button">
        Back to Home
      </button>
      <div className="user-icon-container">
        <FaClipboardList className="user-icon" /> {/* Title icon */}
      </div>
      <h1 className="bus-requests-title">Bus Requests</h1>

      {loading ? (
        <div className="loading-container">
          <div className="spinner"></div>
          <p>Loading requests...</p>
        </div>
      ) : (
        <div className="table-wrapper">
          <table className="users-table">
            <thead>
              <tr>
                <th>#</th>
                <th>UID</th>
                <th>Status</th>
                <th>Date</th>
                <th>Time</th>
                <th>Destination</th>
                <th>Assembly Location</th>
                <th>Number of Buses</th>
                <th>Reason</th>
                <th>Club Name</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {requests.map((request, index) => (
                <tr
                  key={request.id}
                  className={index % 2 === 0 ? "even-row" : "odd-row"}
                >
                  <td>{index + 1}</td>
                  <td>{request.id}</td>
                  <td
                    style={{
                      color:
                        request.status === "Approved"
                          ? "green"
                          : request.status === "Rejected"
                          ? "red"
                          : "orange",
                    }}
                  >
                    {request.status}
                  </td>
                  <td>{request.date || "N/A"}</td>
                  <td>{request.timeOfEvent || "N/A"}</td>
                  <td>{request.destination || "N/A"}</td>
                  <td>{request.assemblyLocation || "N/A"}</td>
                  <td>{request.numberOfBuses || "N/A"}</td>
                  <td>{request.reasonOfEvent || "N/A"}</td>
                  <td>{request.clubName || "N/A"}</td>
                  <td>
                    {request.status === "In Process" && (
                      <>
                        <button
                          onClick={() =>
                            updateRequestStatus(request.id, "Approved")
                          }
                          style={{
                            backgroundColor: "green",
                            color: "white",
                            border: "none",
                            padding: "5px 10px",
                            borderRadius: "5px",
                            cursor: "pointer",
                            marginRight: "5px",
                          }}
                        >
                          Approve
                        </button>
                        <button
                          onClick={() =>
                            updateRequestStatus(request.id, "Rejected")
                          }
                          style={{
                            backgroundColor: "red",
                            color: "white",
                            border: "none",
                            padding: "5px 10px",
                            borderRadius: "5px",
                            cursor: "pointer",
                          }}
                        >
                          Reject
                        </button>
                      </>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}

export default BusRequestsPage;
