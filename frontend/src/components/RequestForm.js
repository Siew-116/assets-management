import React, { useState, useEffect } from "react";
import axios from "axios";

const RequestForm = ({ onCreated }) => {
  const [formData, setFormData] = useState({
    staffID: "",
    remarks: "",
    asset_name: "",
    description: "",
    category: "",
    unit_price: 1,
    requested_qty: 1,
  });

  const [loading, setLoading] = useState(false);
  const [successMsg, setSuccessMsg] = useState("");
  const [errorMsg, setErrorMsg] = useState("");

  useEffect(() => {
    if (successMsg) {
      const timer = setTimeout(() => setSuccessMsg(""), 3000);
      return () => clearTimeout(timer);
    }
    if (errorMsg) {
      const timer = setTimeout(() => setErrorMsg(""), 3000);
      return () => clearTimeout(timer);
    }
  }, [successMsg, errorMsg]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setSuccessMsg("");
    setErrorMsg("");

    try {
      const payload = {
        ...formData,
        unit_price: Number(formData.unit_price),
        requested_qty: Number(formData.requested_qty),
      };

      const response = await axios.post(
        "http://localhost/assets-management/backend/index.php?resource=request&action=createRequestWithNewAsset",
        payload,
        { headers: { "Content-Type": "application/json" } }
      );

      if (response.data.status === "success") {
        setSuccessMsg(
          `Request #${response.data.requestID} created successfully!`
        );

        setFormData({
          staffID: "",
          remarks: "",
          asset_name: "",
          description: "",
          category: "",
          unit_price: 1,
          requested_qty: 1,
        });
        setTimeout(() => {
            if (onCreated) onCreated();
        }, 2000);
      
      } else {
        setErrorMsg(response.data.msg || "Unknown error");
      }
    } catch (err) {
      console.error(err);
      setErrorMsg("Error creating request. Check console.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <>
      {successMsg && <div className="toast success-toast">{successMsg}</div>}
      {errorMsg && <div className="toast error-toast">{errorMsg}</div>}

      <form onSubmit={handleSubmit} className="new-request-form">
        <h3>Create New Request</h3>

        <div className="form-group">
          <label>Staff ID*</label>
          <input
            type="text"
            name="staffID"
            value={formData.staffID}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label>Asset Name*</label>
          <input
            type="text"
            name="asset_name"
            value={formData.asset_name}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label>Description (Optional)</label>
          <textarea
            type="text"
            name="description"
            value={formData.description}
            onChange={handleChange}
          />
        </div>

        <div className="form-group">
          <label>Category*</label>
          <input
            type="text"
            name="category"
            value={formData.category}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label>Unit Price (RM)*</label>
          <input
            type="number"
            name="unit_price"
            value={formData.unit_price}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label>Requested Quantity*</label>
          <input
            type="number"
            name="requested_qty"
            value={formData.requested_qty}
            min={1}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label>Remarks(Optional)</label>
          <textarea
            name="remarks"
            value={formData.remarks}
            onChange={handleChange}
          />
        </div>
        <div className="submit-section">
            <button type="submit" className="btn submit-request-btn" disabled={loading}>
            {loading ? "Creating..." : "Submit Request"}
            </button>
        </div>
      </form>
    </>
  );
};

export default RequestForm;