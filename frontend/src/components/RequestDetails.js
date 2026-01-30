import React, { useEffect, useState } from "react";
import axios from "axios";

const RequestDetails = ({ requestID, initialData, onClose, inline }) => {
  const [requestData, setRequestData] = useState(initialData || null);
  const [loading, setLoading] = useState(!initialData);

  useEffect(() => {
    if (requestID && !initialData) {
      setLoading(true);
      axios
        .get(
          `http://localhost/assets-management/backend/index.php?resource=request&action=getDetail&requestID=${requestID}`
        )
        .then((res) => setRequestData(res.data))
        .catch((err) =>
          console.error("Error fetching request details:", err)
        )
        .finally(() => setLoading(false));
    }
  }, [requestID, initialData]);

  if (!requestID && !initialData) return null;

 
  const wrapperClass = inline
    ? "inline-request-details"
    : "modal-overlay";

  const contentClass = inline
    ? "inline-request-content"
    : "modal-content";

  return (
    <div className={wrapperClass}>
      <div className={contentClass}>
        {!inline && onClose && (
          <button className="close-btn" onClick={onClose}>
            &times;
          </button>
        )}

        {loading ? (
          <p>Loading request details...</p>
        ) : requestData ? (
          <>
            <span
              className={`status ${requestData.status?.toLowerCase() || ""}`}
            >
              {requestData.status || "—"}
            </span>
            <h3>Request Details - ID #{requestData.requestID}</h3>
            <hr />

            {/* Staff Section */}
            {requestData.staff_name || requestData.department ? (
              <div className="detail-section">
                <h3>Staff Details</h3>
                <div className="grid-row">
                  <p>Staff Name</p>
                  <p>{requestData.staff_name || "—"}</p>
                  <p>Department</p>
                  <p>{requestData.department || "—"}</p>
                  <p>Position</p>
                  <p>{requestData.position || "—"}</p>
                  <p>Phone</p>
                  <p>{requestData.phone || "—"}</p>
                  <p>Email</p>
                  <p>{requestData.email || "—"}</p>
                </div>
              </div>
            ) : null}

            {/* Assets / Request Items */}
            {requestData.items?.length > 0 && (
              <div className="detail-section">
                <h3>Assets Details</h3>
                {requestData.items.map((item, idx) => (
                  <div key={idx} className="grid-row item-row">
                    <p>Item Name</p>
                    <p>{item.asset_name || "—"}</p>
                    <p>Description</p>
                    <p>{item.description || "—"}</p>
                    <p>Requested Quantity</p>
                    <p>{item.requested_qty ?? "—"}</p>
                    <p>Ordered Quantity</p>
                    <p>{item.ordered_qty ?? "—"}</p>
                    <p>Received Quantity</p>
                    <p>{item.received_qty ?? "—"}</p>
                    <p>Accepted Quantity</p>
                    <p>{item.accepted_qty ?? "—"}</p>
                    <p>Rejected Quantity</p>
                    <p>{item.rejected_qty ?? "—"}</p>
                    <p>Unit Price</p>
                    <p>
                      {item.unit_price
                        ? `RM ${Number(item.unit_price).toFixed(2)}`
                        : "—"}
                    </p>
                    <p>Total Price</p>
                    <p>
                      {item.total_price
                        ? `RM ${Number(item.total_price).toFixed(2)}`
                        : "—"}
                    </p>
                    <p>Remarks</p>
                    <p>{item.remarks || "—"}</p>
                  </div>
                ))}
              </div>
            )}
          </>
        ) : (
          <p>No request details found</p>
        )}
      </div>
    </div>
  );
};

export default RequestDetails;
