import Navbar from './NavBar.js';
import Sidebar from './SideBar.js';
import React, { useState, useEffect } from 'react';
import Dashboard from '../pages/Dashboard';
import axios from 'axios';

const Layout = () => {
  const [activeTab, setActiveTab] = useState("requests"); // default tab
  const [requests, setRequests] = useState([]);

  const fetchRequests = async () => {
    try {
      const response = await axios.get(
        "http://localhost/assets-management/backend/api/requests.php?action=list_requests"
      );
      const data = Array.isArray(response.data) ? response.data : [];
      setRequests(data);
    } catch (error) {
      console.error("Error fetching requests:", error);
    }
  };

  useEffect(() => {
    if (activeTab === "requests") fetchRequests();
  }, [activeTab]);

  return (
    <div className="layout">
      <Navbar fetchRequests={fetchRequests} />
      <div className='layout-row'>
        <Sidebar activeTab={activeTab} setActiveTab={setActiveTab} />
        <div className="layout-content">
          <Dashboard
            activeTab={activeTab}
            setActiveTab={setActiveTab}
            requests={requests}
            fetchRequests={fetchRequests}
          />
        </div>
      </div>
    </div>
  );
};

export default Layout;
