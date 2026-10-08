import { LightningElement } from 'lwc';

export default class ComplaintPriorityDashboard extends LightningElement {
    metrics = {
        totalCases: 128,
        highPriority: 42,
        mediumPriority: 51,
        lowPriority: 35
    };
}
