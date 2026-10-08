import { LightningElement } from 'lwc';

export default class SupportDashboard extends LightningElement {
    metrics = [
        { label: 'Open Cases', value: '128', trend: '+8% vs last week' },
        { label: 'SLA Breached', value: '09', trend: '-3% vs last week' },
        { label: 'Critical Cases', value: '17', trend: '+2 urgent' },
        { label: 'Resolved Today', value: '42', trend: '+12%' }
    ];
}
