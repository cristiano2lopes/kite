# Pre-requisites

* Flutter 3.29.2
* Ruby 3.3.5

For ruby you can use [Mise]("https://github.com/jdx/mise") to intalls without conflicting with your setup.
For flutter you can use [FVM](https://fvm.app) or some other similar tool

# Developing

1. Install the pre-requisites
2. Run `bundler` to install the ruby dependencies

        bundle install

3. Run the app with flutter from `./kite` directory and follow the instructions

        flutter run

## Project created with

    flutter create  --platforms ios,android --org "lol.cristiano.kite" kite

## Architecture

Development a modified version of the MVVM architecture with the addition of Service objects
that encapsulate external dependencies - boundaries – of the app such as
Api Requests, Device hardware access and domain logic.

Services are composed in a composition root near the application bootstrap for a
clear graph of dependencies and ease of testing. 

## Misc

`json_serializable` is used for code gen of json models. After changes to those models
you will need to run the following command to generate the code:

    dart run build_runner build --delete-conflicting-outputs

# Deploy

For now deploys run locally. Moving to a ci/cd is a matter of
adding automation to the codesigning resources setup and use the same
existing fastlane commands.

## Deploy iOS

To deploy the app on iOS, assuming you have codesigning resources configured for it:

1. `export FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD="FILL APP SPECIFIC PASS"`
2. From the project root `bundle exec fastlane ios deploy`
3. App will be deployed to TF

## Deploy Android

1. `export APP_SIGNING_KEYSTORE_PATH="FULL PATH TO JKS"`
2. `export APP_SIGNING_KEYSTORE_PASSWORD="JKS PASS"`
3. From the project root `bundle exec fastlane android deploy`
4. Artifacts for testing and upload to Play Store will be available on the `builds` folder on the project root
