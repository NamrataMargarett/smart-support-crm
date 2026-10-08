import { LightningElement } from 'lwc';

export default class SmartSupportCaseDashboard extends LightningElement {
    metrics = {
        totalCases: 128,
        openCases: 42,
        criticalCases: 7,
        escalatedCases: 11,
        resolvedCases: 63,
        closedCases: 23
    };
}
