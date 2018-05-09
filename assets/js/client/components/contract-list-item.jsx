import React, { Component } from "react";
import { ListGroupItem, Table } from 'reactstrap';
import Moment from 'react-moment';

class ContractListItem extends Component {
  render() {
    const contract = this.props.contract;

    return (
      <ListGroupItem className="shadow-sm rounded mb-3" onClick={() => this.props.selected(contract)}>
        <Table>
          <tbody>
            <tr>
              <th>Vendor</th>
              <th>Category</th>
              <th>Costs</th>
              <th>Ends On</th>
            </tr>
            <tr>
              <td>{contract.vendor}</td>
              <td>{contract.category}</td>
              <td>{contract.costs}</td>
              <td><Moment format="MMM DD, YYYY">{contract.ends_on}</Moment></td>
            </tr>
          </tbody>
        </Table>
      </ListGroupItem>
    )
  }
}

export default ContractListItem;
