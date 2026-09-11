# Application catalog

`apps.json` is the explicit inventory of applications that Engineer may describe as target projects. It is initialized empty. A missing entry means this workspace has no recorded ownership, repository location, architecture evidence, release authority, or access rights for that application.

## Registration requirements

Add an application only after the owner explicitly provides or approves:

- stable identifier and human-readable name;
- repository or local path and an appropriate non-secret reference;
- platform/scope and current lifecycle status;
- ownership/contact role;
- evidence boundary: what may be inspected and what remains out of scope;
- production status and the fact that production approval remains required;
- verification date for recorded metadata.

Do not store credentials, access tokens, private customer data, signing details, private URLs, or production-control values in the catalog.

## Planned entry shape

Future entries should use this shape after schema validation is implemented:

```json
{
  "id": "stable-lowercase-id",
  "name": "Human-readable name",
  "status": "planned | active | archived",
  "platforms": ["android"],
  "repository": {
    "location": "owner-approved, non-secret path or URL",
    "revision": "verified commit or release reference"
  },
  "ownership": {
    "role": "owner-approved contact role"
  },
  "production": {
    "enabled": false,
    "explicitApprovalRequired": true
  },
  "verifiedAt": "YYYY-MM-DD"
}
```

The example is illustrative only; it is not an actual registered app or a declaration that the referenced fields are implemented. Registering an app does not authorize access to it or any associated system.
