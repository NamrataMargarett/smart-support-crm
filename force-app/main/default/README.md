# SmartSupport CRM - Salesforce Project Skeleton

This directory is the Salesforce metadata foundation for the SmartSupport CRM project.

## Included structure
- classes/
- flows/
- lwc/
- objects/
- permissionsets/
- queues/
- reports/
- dashboards/

## Recommended implementation plan
1. Create custom support objects and fields
2. Set up queue routing rules
3. Configure SLA configuration metadata
4. Add LWC dashboard cards
5. Implement case assignment logic in Apex
6. Connect AI prediction service to support records

## VS Code workflow
Open the repo in VS Code, install the Salesforce extension pack, then deploy using:

```bash
sfdx force:source:deploy -p force-app
```
