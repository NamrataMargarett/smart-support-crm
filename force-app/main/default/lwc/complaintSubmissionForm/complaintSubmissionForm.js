import { LightningElement, track } from 'lwc';
import createComplaint from '@salesforce/apex/ComplaintController.createComplaint';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ComplaintSubmissionForm extends LightningElement {
    @track isSubmitting = false;
    @track showForm = true;

    categories = [
        { label: 'Billing', value: 'Billing' },
        { label: 'Shipping', value: 'Shipping' },
        { label: 'Hardware', value: 'Hardware' },
        { label: 'Software', value: 'Software' },
        { label: 'Account', value: 'Account' }
    ];

    severities = [
        { label: 'Low', value: 'Low' },
        { label: 'Medium', value: 'Medium' },
        { label: 'High', value: 'High' },
        { label: 'Critical', value: 'Critical' }
    ];

    handleSubmit(event) {
        event.preventDefault();
        this.isSubmitting = true;

        const fields = event.detail.fields;

        createComplaint({
            accountName: fields.AccountName,
            email: fields.Email,
            category: fields.Category,
            description: fields.Description,
            priority: fields.Priority || 'Medium',
            severity: fields.Severity || 'Medium'
        })
            .then(() => {
                this.showToast('Success', 'Complaint submitted successfully!', 'success');
                this.showForm = false;
                setTimeout(() => {
                    this.showForm = true;
                    this.template.querySelector('form').reset();
                }, 2000);
            })
            .catch((error) => {
                this.showToast('Error', error.body.message, 'error');
            })
            .finally(() => {
                this.isSubmitting = false;
            });
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(evt);
    }
}
