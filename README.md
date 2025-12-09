# RAP Unmanaged Scenario using Business Object for Sales Order

To create an unmanaged scenario in RAP, we must manually build everything ourselves. For that, we need to go through all layers of CDS + Behavior Definitions and Behavior Implementations.

In the following example, we use the Sales Order BO (I_SALESORDERTP).

To find a BO provided by SAP, we can do the following:

Access SAP HUB > SAP S/4HANA Cloud Private Edition > On Stack Extensibility > [Business Object Interfaces](https://hub.sap.com/products/SAPS4HANACloudPrivateEdition/onstackextensibility/bointerface)

### Create BASIC CDS Views:
In the following scenario, we created two Basic views: ZI_SO_BM (for Sales Order Header) and ZI_SO_ITEM_BM (for Sales Order Item). We only fetch the most relevant data, in a more raw form.

### Create COMPOSITE Views:
Our Composite Views are based on our Basics. They are ZR_SO_BM (ROOT) and ZR_SO_ITEM_BM.

Our Header Composite will have a composition with our Item view using the statement:
composition [0..*] of zr_so_item_bm as _item

Our Item Composite will have an association with our Header view using the statement:
association to parent zr_so_bm as _so on $projection.SalesOrder = _so.SalesOrder
In this statement, we are passing the keys that link our entities.

### Create CONSUMPTION Views:
Our Consumption Views are based on our Composites and must be of type Projection (required by the framework to create Behaviors). They are ZC_SO_BM (ROOT) and ZC_SO_ITEM_BM.

### Create the Behavior Definitions and Implementations:
For the Behavior Definitions, we will create two, based on our Header Composite and Consumption Views (ZR_SO_BM and ZC_SO_BM, respectively).

We must do this because in our Composite Behavior we will include ALL behaviors and their implementations, while in our Consumption Behavior we expose only those we choose. This is due to reusability and the way the RAP architecture was designed.

### Create the Service Definition and Service Binding:
We must create the Service Definition and Service Binding to expose our projections (ZC_PO_BM and ZC_PO_ITEM_BM).


## Testing the services through Postman

### Method Get Token (to fetch the Token to be used on other operations)
<img width="1405" height="668" alt="image" src="https://github.com/user-attachments/assets/83bcfdf6-d64e-4fd4-b6ea-4551b8192ccf" />

### Method Create Sales Order
<img width="1458" height="741" alt="image" src="https://github.com/user-attachments/assets/c350ab9e-9df7-4fdf-af24-a10eeb73439f" />

<img width="871" height="598" alt="image" src="https://github.com/user-attachments/assets/c0632078-9a64-4e3d-9a67-85eb5d680f5d" />

### Method Sales Order Update
<img width="1461" height="662" alt="image" src="https://github.com/user-attachments/assets/379683dc-76d5-4028-837b-7ae702af538f" />

<img width="871" height="590" alt="image" src="https://github.com/user-attachments/assets/e04182ee-922e-4646-af8e-2bcaa3e6f31e" />

### Method Update Sales Order Item
<img width="1477" height="641" alt="image" src="https://github.com/user-attachments/assets/fe333aa6-4061-4c3b-9e51-f8b5f532dd01" />

<img width="1005" height="608" alt="image" src="https://github.com/user-attachments/assets/5a1222d3-6a64-446f-813d-712515f3365c" />

### Method Delete Sales Order Item

Trying to delete a non existing item
<img width="1456" height="868" alt="image" src="https://github.com/user-attachments/assets/7e05e5b8-3a49-474e-aecc-b77dfa5cae4a" />

Deleting existing Item
<img width="1414" height="744" alt="image" src="https://github.com/user-attachments/assets/736d18e3-3116-41d5-9e78-a0f6206b759a" />

<img width="1031" height="571" alt="image" src="https://github.com/user-attachments/assets/646cee2a-e3dd-4b05-b94a-b1a2d2b0a944" />






