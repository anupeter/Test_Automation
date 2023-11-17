#!/usr/bin/env bash

rake website_exec[uae,website,staging,org,broker1,desktop,2,chrome,en,off] &
sleep 1
rake website_regression[uae,website,staging,cover1,broker2,desktop,2,chrome,en,off,regression] &
sleep 1
rake website_exec[egy,website,staging,org,desktop,2,chrome,en,off]
wait
rake gather_statistics[desktop,staging]