import React, { Component } from "react";
import { Container, Button, Row, Col, ListGroup, ListGroupItem } from 'reactstrap';
import axios from "axios";
import ContractListItem from "../components/contract-list-item";
import ContractForm from "../components/contract-form";
import Moment from 'react-moment';


class Contracts extends Component {
  constructor(props) {
    super(props);

    this.state = {
      contractList: [],
      selectedContract: null,
      isFormOpen: false,
      isContractShow: false
    };

    this.getContractList = this.getContractList.bind(this);
  }

  componentWillMount() {
    this.getContractList();
  }

  getContractList() {
    axios.get("/api/v1/contracts")
      .then(response => this.setState(Object.assign(this.state, { contractList: response.data.data })))
      .catch(error => console.log(error));
  }

  selectContract(contract) {
    this.setState(
      Object.assign(
        this.state, {
          selectedContract: contract,
          isContractShow: true
        }
      )
    );
  }

  createNewContract() {
    this.setState(
      Object.assign(
        this.state, {
          isFormOpen: true
        }
      )
    );
  }

  contractListUpdated() {
    this.getContractList();
    this.setState(
      Object.assign(
        this.state, {
          isContractShow: false,
          selectedContract: null,
          isFormOpen: false
        }
      ),
      () => console.log(this.state)
    );
  }

  isEditingContract() {
    this.setState(Object.assign(this.state, { isFormOpen: true }));
  }

  isDeletingContract() {
    const confirm = window.confirm("Are you sure!!");

    if (!confirm) { return }

    axios.delete(`/api/v1/contracts/${this.state.selectedContract.id}`)
      .then(res => this.contractListUpdated.bind(this)())
      .catch(error => console.log(error));
  }

  renderContractList() {
    console.log(this.state)
    if (this.state.isContractShow || this.state.isFormOpen) { return }
    return (
      <ListGroup className="contract-list mt-3">
        <h4 className="text-center">
          My Contracts <br />
          <Button className="my-3 btn-success border-0 shadow-sm" onClick={this.createNewContract.bind(this)}>Add Contract</Button>
        </h4>
        {
          this.state
            .contractList
            .map(item =>
              <ContractListItem
                key={item.id}
                contract={item}
                selected={this.selectContract.bind(this)}></ContractListItem>
            )
        }
        {this.state.contractList.length ? null : (<ListGroupItem className="shadow-sm rounded mb-3 text-center"><h3>No Records found</h3></ListGroupItem>)}
      </ListGroup>
    );
  }

  renderContractForm() {
    if (!this.state.isFormOpen) { return }
    return <ContractForm contractSubmitted={this.contractListUpdated.bind(this)} contract={this.state.selectedContract}></ContractForm>;
  }

  renderContract() {
    const selectedContract = this.state.selectedContract
    if (!(this.state.isContractShow && selectedContract && !this.state.isFormOpen)) { return }
    return (
      <div>
        <h3 className="text-center">Contract Details</h3>
        <dl className="col-md-4 offset-md-4 my-5">
          <dt>Vendor</dt>
          <dd>{selectedContract.vendor}</dd>
          <dt>Category</dt>
          <dd>{selectedContract.category}</dd>
          <dt>Costs</dt>
          <dd>{selectedContract.costs}</dd>
          <dt>Ends on</dt>
          <dd><Moment format="MMM DD, YYYY">{selectedContract.ends_on}</Moment></dd>
        </dl>
        <h3 className="text-center">
          <Button className="mx-3 btn-info border-0" onClick={this.isEditingContract.bind(this)}>Edit</Button>
          <Button className="mx-3 btn-danger border-0" onClick={this.isDeletingContract.bind(this)}>Delete</Button>
        </h3>
      </div>
    )
  }

  render() {
    return (
      <Container className="pt-5">
        <Row className="justify-content-md-center">
          <Col sm="12" md={{ size: 8 }}>
            {this.renderContractForm()}
            {this.renderContract()}
            {this.renderContractList()}
          </Col>
        </Row>

      </Container>
    )
  }
}

export default Contracts;
