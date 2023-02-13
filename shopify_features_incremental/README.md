## Incremental Features

This is a poc on Incremental features using Shopify features. The assumption is as  follows:
1. For the very first time, shopify_features_batch/ project should be run. This creates a `shopify_user_features_incremental` feature table along with the id graph table (`shopify_user_id_stitcher`)
2. From then, this project (`shopify_features_incremental/`) should run. Before running, the view in `views/incremental_features_view.sql` should be created
3. This creates a view on top of the feature table that got created in step 1. The view drops main_id and creates multiple columns, one per identifier from id graph. It creates same number of rows too - i.e., data gets duplicated as per the identifiers
4. In this project, following steps are done:
    4.1: Incremental features are created based on last time stamp from the current `shopify_user_features_incremental` table, then taking events from inputs tables only after this timestamp
    4.2: Current snapshot of the features are taken from the view created in step 3 (which is an image of `shopify_user_features_incremental`)
    4.3: The incremental features are merged with batch features, to recreate the `shopify_user_features_incremental` table with updated values

The batch project needs to be run only one time. After that, only the incremental project needs to be run on daily cadence. If there was a change in either of the projects, even if in incremental project alone, batch project needs to be re-run again to re-create the base table

Optimisations required in profiles:
1. Natively pick end time from the feature table and use that as a parameter
2. Work with the assumption that feature table can be one of the inputs (current obstacle is that main_id can't be part of an input table)
