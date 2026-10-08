import { LightningElement } from 'lwc';

export default class SmartSupportDashboardPremium extends LightningElement {
    metrics = {
        totalCases: 128,
        openCases: 42,
        criticalCases: 7,
        escalatedCases: 11,
        resolvedCases: 63,
        closedCases: 23
    };

    get caseTrend() {
        return '+12.5% vs last month';
    }

    get resolvedTrend() {
        return '+9.2% uplift';
    }

    get openTrend() {
        return '-4.1% this week';
    }
}
