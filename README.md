Tekton source code to create an simple ace flow

### Webhook

Webhooks have been configured to trigger pipelines after certain events.

- The EventListener creates a pod that awaits a payload from a 3rd party resource such as GitHub or Artifactory. For example, when GitHub detects a push event, it sends a payload to a Route configured for the EventListener (ensure you have exposed the EventListener Service).
- The TriggerBinding takes an event payload and sets one of its field values to a variable to be used in the TriggerTemplate.
- The TriggerTemplate specifies how the pipeline is instantiated, for example the commit id is used to set a unique PipelinRun name as you can not have two PipelineRuns with the same name, we can also specify which PipelineResources to use in the PipelineRun.

## Configure a webhook in GitHub

- From your repository's page go to `Setting > Webhooks > Add webhook`.
- In Payload URL enter the URL of the Route that points to the EventListener Service responsible for triggering the appropriate pipeline.
- For `Content type`, select `application/json`.
- Leave `Which events would you like to trigger this webhook?` as `Just the push event`.
- Ensure the `Active` checkbox is selected.
- Finally, click `Add webhook`.

## Configure a webhook in Artifactory

- From your Artifactory Dashboard go to`Administration > General > Webhooks`.
- Click `New Webhook`.
- Provide a Name in the `Name` field.
- Enter the URL of the Route that points to the EventListener Service responsible for triggering the appropriate pipeline in the `URL` field.
- Under Events select `Artifact > Artifact was deployed`.
- Click `Select Repositories` and choose which repository this webhook will watch for events by adding it to the `Included Respoitories` section and press `Save`.
- Finally click `Create`.
