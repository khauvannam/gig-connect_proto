Proto Project
=============

This repository contains Protocol Buffer (.proto) message definitions.

--------------------------------------------------
Project Structure
--------------------------------------------------
proto/
  service/        Service-level .proto files (user, auth, booking, etc.)
  common/         Shared messages (types, errors, pagination)
  google/         External well-known types if needed

generated/        Auto-generated code (per language)

--------------------------------------------------
Usage
--------------------------------------------------

Generate code:
    make proto-gen

This will create generated message classes in:
    generated/go/
    generated/js/
    generated/python/
    generated/java/

Lint proto files:
    make proto-lint

--------------------------------------------------
Notes
--------------------------------------------------
- .proto files define the schema for all services.
- The "generated/" folder contains build output and should not be manually edited.
