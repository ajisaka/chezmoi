 | jq '.Stacks[] | .Outputs | reduce .[] as $it ({}; .[$it.OutputKey] = $it.OutputValue)'

