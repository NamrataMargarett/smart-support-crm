import { LightningElement, track } from 'lwc';
import getComplaintMetrics from '@salesforce/apex/ComplaintController.getComplaintMetrics';
import getComplaintsOrderedByPriority from '@salesforce/apex/ComplaintController.getComplaintsOrderedByPriority';
import getCategoryDistribution from '@salesforce/apex/ComplaintController.getCategoryDistribution';
import { refreshApex } from '@salesforce/apex';

export default class ComplaintPriorityQueue extends LightningElement {
    @track metrics = {};
    @track complaints = [];
    @track categoryData = [];
    @track isLoading = true;
    @track error = null;

    wiredMetricsResult;
    wiredComplaintsResult;
    wiredCategoryResult;

    connectedCallback() {
        this.loadData();
    }

    loadData() {
        this.isLoading = true;
        this.loadMetrics();
        this.loadComplaints();
        this.loadCategories();
    }

    loadMetrics() {
        getComplaintMetrics()
            .then((result) => {
                this.metrics = result;
                this.error = null;
            })
            .catch((error) => {
                this.error = error.body.message || 'Error loading metrics';
                console.error('Error:', error);
            })
            .finally(() => {
                this.isLoading = false;
            });
    }

    loadComplaints() {
        getComplaintsOrderedByPriority()
            .then((result) => {
                this.complaints = result.map((complaint) => ({
                    ...complaint,
                    createdDateFormatted: new Date(complaint.CreatedDate).toLocaleDateString()
                }));
            })
            .catch((error) => {
                console.error('Error loading complaints:', error);
            });
    }

    loadCategories() {
        getCategoryDistribution()
            .then((result) => {
                this.categoryData = result;
            })
            .catch((error) => {
                console.error('Error loading categories:', error);
            });
    }

    get highPriorityPercent() {
        if (this.metrics.totalCases === 0) return 0;
        return Math.round((this.metrics.highPriority / this.metrics.totalCases) * 100);
    }

    get mediumPriorityPercent() {
        if (this.metrics.totalCases === 0) return 0;
        return Math.round((this.metrics.mediumPriority / this.metrics.totalCases) * 100);
    }

    get lowPriorityPercent() {
        if (this.metrics.totalCases === 0) return 0;
        return Math.round((this.metrics.lowPriority / this.metrics.totalCases) * 100);
    }
}
