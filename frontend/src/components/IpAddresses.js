import React, { Component } from 'react';
import ReactTable from 'react-table';
import "react-table/react-table.css";


export class IpAddresses extends Component {


  render() {
    const columns = [
      { Header: 'ID', accessor: 'id' },
      { Header: 'IPaddress', accessor: 'ipaddress' },
      { Header: 'Created', accessor: 'created' }

    ];

    return (
      <div>
        <div className="tableDesc">PostgreSQL IP Addresses records</div>
        <ReactTable className="reactTable"
          data={this.props.allAddress}
          columns={columns}
          defaultPageSize={10}
          pageSizeOptions={[10, 15, 20, 50]}
        />
      </div>
    )


  }
}

export default IpAddresses
