import React, { useState } from "react";
import RequestForm from "../components/RequestForm";

const Navbar = ({ fetchRequests }) => {
  const [showNewRequestModal, setShowNewRequestModal] = useState(false);

  return (
    <>
      <nav className="navbar">
        <h2>Asset Management System</h2>
        <div className="right-nav">
          {/* Open the modal */}
          <button
            className="btn add-new-btn"
            onClick={() => setShowNewRequestModal(true)}
          >
            +
          </button>
          <i className="fa-solid fa-user"></i>
        </div>
      </nav>

      {/* New Request + Asset Modal */}
      {showNewRequestModal && (
        <div className="modal-overlay">
          <div className="modal-content">
            <button
              className="close-btn"
              onClick={() => setShowNewRequestModal(false)}
            >
              &times;
            </button>

            <RequestForm
              onCreated={async () => {
                if (fetchRequests) await fetchRequests(); // wait for refresh
                setShowNewRequestModal(false);           // then close modal
              }}
            />
          </div>
        </div>
      )}
    </>
  );
};

export default Navbar;
