import React, { useEffect, useState } from "react";
import RequestDetails from "../components/RequestDetails";
import axios from "axios";
import '../App.css';


const statusOptions = [
  { label: "All", value: "All" },
  { label: "Pending", value: "Pending" },
  { label: "Approved", value: "Approved" },
  { label: "Rejected", value: "Rejected" },
  { label: "Received", value: "Received" },
  { label: "Returned", value: "Returned" },
  { label: "Inspected", value: "Inspected" },
  { label: "Completed", value: "Completed" },
];


const Dashboard = ({ activeTab, setActiveTab, requests, fetchRequests }) => {
  
  const [filter, setFilter] = useState("All");
  const [selectedRequest, setSelectedRequest] = useState(null);
  const [showDetailsModal, setShowDetailsModal] = useState(false);
  const [loadingDetails, setLoadingDetails] = useState(false);
  const [inventory, setInventory] = useState([]);
  const [selectedInventory, setSelectedInventory] = useState(null);
  const [showInventoryModal, setShowInventoryModal] = useState(false);
  const [selectedInventoryTab, setSelectedInventoryTab] = useState("info");
  

  const filteredRequests =
    filter === "All"
      ? requests
      : requests.filter((r) => r.status === filter);

  const handleRequestView = async (request) => {
    setLoadingDetails(true);
    try {
      const response = await axios.get(
        `http://localhost/assets-management/backend/index.php?resource=request&action=getDetail&requestID=${request.requestID}`
      );
      setSelectedRequest(response.data);
      setShowDetailsModal(true);
    } catch (error) {
      console.error("Error fetching request details:", error);
    } finally {
      setLoadingDetails(false);
    }
  };

  useEffect(() => {
    if (activeTab === "inventory") {
      fetchInventory();
    }
  }, [activeTab]);

  const fetchInventory = async () => {
    try {
      const response = await axios.get(
        "http://localhost/assets-management/backend/index.php?resource=inventory&action=list"
      );
      setInventory(Array.isArray(response.data) ? response.data : []);
    } catch (error) {
      console.error("Error fetching inventory:", error);
    }
  };

   const handleInventoryView = (item) => {
    setSelectedInventory(item);
    setShowInventoryModal(true);
  };


  return (
    <>
      <div className="dashboard-layout">
      
        <div className="dashboard-content">
          {/* PR tab */}
          {activeTab === "requests" && (
            <>
              <div className="status-btns">
                {statusOptions.map((s) => (
                  <button
                    key={s.value}
                    className={filter === s.value ? "active" : ""}
                    onClick={() => setFilter(s.value)}
                  >
                    {s.label} {s.value !== "All" && `${(requests || []).filter(r => r.status === s.value).length}`}
                  </button>
                ))}
              </div>

              <div className="table-container">
                <table>
                  <thead>
                    <tr>
                      <th>Request ID</th>
                      <th>Asset</th>
                      <th>Remarks</th>
                      <th>Staff</th>
                      <th>Status</th>
                      <th>Total Items</th>
                      <th>Total Amount</th>
                      <th>Created At</th>
                      <th>More Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    {filteredRequests.length === 0 ? (
                      <tr>
                        <td colSpan="7">No requests found</td>
                      </tr>
                    ) : (
                      filteredRequests.map((r) => (
                        <tr key={r.requestID}
                            onClick={() => handleRequestView(r)} >
                          <td>{r.requestID}</td>
                          <td>{r.asset_name}</td>
                          <td>{r.remarks}</td>
                          <td>{r.staff_name}</td>
                          <td>
                            <span className={`status ${r.status.toLowerCase()}`}>
                              {r.status}
                            </span>
                          </td>
                          <td>{r.total_items}</td>
                          <td>RM {Number(r.total_amount).toFixed(2)}</td>
                          <td>{new Date(r.created_at).toLocaleDateString()}</td>
                          <td>
                            <button onClick={() => handleRequestView(r)}>
                              <i className="fa-solid fa-eye"></i>
                            </button>
                          </td>
                        </tr>
                      ))
                    )}
                  </tbody>
                </table>
              </div>
            </>
          )}
          
          {/* Inventory tab */}
          {activeTab === "inventory" && (
            <>
              <div className="status-btns">
                {["All", "AVAILABLE", "IN_USE", "IN_REPAIR", "DISPOSED"].map((s) => (
                  <button
                    key={s}
                    className={filter === s ? "active" : ""}
                    onClick={() => setFilter(s)}
                  >
                    {s} {s !== "All" && inventory.filter(i => i.status === s).length}
                  </button>
                ))}
              </div>
              {/* Inventory list */}
              <div className="table-container">
                <table>
                  <thead>
                    <tr>
                      <th>Inventory ID</th>
                      <th>Asset Name</th>
                      <th>Serial Number</th>
                      <th>Location</th>
                      <th>Status</th>
                      <th>Assigned To</th>
                      <th>Image</th>
                      <th>More Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    {(filter === "All" ? inventory : inventory.filter(i => i.status === filter)).length === 0 ? (
                      <tr>
                        <td colSpan="7">No inventory found</td>
                      </tr>
                    ) : (
                      (filter === "All" ? inventory : inventory.filter(i => i.status === filter)).map((item) => (
                        <tr key={item.inventoryID} onClick={() => handleInventoryView(item)}>
                          <td>{item.inventoryID}</td>
                          <td>{item.asset_name || "—"}</td>
                          <td>{item.serial_number || "—"}</td>
                          <td>{item.location || "—"}</td>
                          <td>
                            <span className={`status ${item.status?.toLowerCase()}`}>
                              {item.status}
                            </span>
                          </td>
                          <td>{item.staff_name || "—"}</td>
                          <td>
                            {item.img ? (
                              <img src={`http://localhost/assets-management/backend/uploads/${item.img}`} alt="asset" style={{ width: "50px" }} />
                            ) : "—"}
                          </td>
                          <td>
                            <button onClick={() => handleInventoryView(item)}>
                              <i className="fa-solid fa-eye"></i>
                            </button>
                          </td>
                        </tr>
                      ))
                    )}
                  </tbody>
                </table>
              </div>
            </>
          )}


          {/* Inventory Modal */}
          {showInventoryModal && selectedInventory && (
            <div className="modal-overlay">
              <div className="modal-content">
                <button className="close-btn" onClick={() => setShowInventoryModal(false)}>
                  &times;
                </button>
                <h3>Inventory Details - ID #{selectedInventory.inventoryID}</h3>
                <hr />

                {/* Inventory Info */}
                <div className="detail-section">
                  <p><strong>Asset Name:</strong> {selectedInventory.asset_name || '—'}</p>
                  <p><strong>Serial Number:</strong> {selectedInventory.serial_number || '—'}</p>
                  <p><strong>Image:</strong><br />
                    {selectedInventory.img ? (
                      <img src={`http://localhost/assets-management/backend/uploads/${selectedInventory.img}`} alt="asset" style={{ width: "150px" }} />
                    ) : '—'}
                  </p>
                  <p><strong>Location:</strong> {selectedInventory.location || '—'}</p>
                  <p><strong>Status:</strong> 
                    <span className={`status ${selectedInventory.status?.toLowerCase()}`}>
                      {selectedInventory.status}
                    </span>
                  </p>
                  <p><strong>Assigned To:</strong> {selectedInventory.staff_name || '—'}</p>
                </div>
                
                <div className="toggle-section">
                {/* Toggle Request Details */}
                {selectedInventory.assetID && (
                  <button
                    className={`toggle-request-btn ${selectedInventoryTab === "request" ? "active" : ""}`}
                    onClick={() =>
                      setSelectedInventoryTab(selectedInventoryTab === "request" ? "info" : "request")
                    }
                  >
                    {selectedInventoryTab === "request" ? "Hide ▴" : "View Request Details ▾"}
                  </button>
                )}
                </div>

                {/* Smoothly expand/collapse Request Details */}
                <div
                  className={`request-details-wrapper ${selectedInventoryTab === "request" ? "expanded" : ""}`}
                >
                  {selectedInventoryTab === "request" && selectedInventory.assetID && (
                    <RequestDetails
                      requestID={selectedInventory.requestID}  
                      initialData={selectedRequest}    
                      onClose={() => setSelectedInventoryTab("info")} // switch back to inventory info
                      inline={true} // render inside modal without overlay
                    />
                  )}
                </div>
              </div>
            </div>
          )}

        </div>
      </div>

    {/* Request Details Overlay */}
    {showDetailsModal && (
      <RequestDetails
        requestID={selectedRequest.requestID}
        initialData={selectedRequest}
        onClose={() => setShowDetailsModal(false)}
      />
    )}

  </>
);

}

export default Dashboard;