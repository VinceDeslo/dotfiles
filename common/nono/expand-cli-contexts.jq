def with_context_variants($contexts):
  . as $rule
  | $rule,
    ($rule
      | select(.argv.prefix != null)
      | $contexts[] as $context
      | (.argv.prefix |= ["--context", $context] + .),
        (.argv.prefix |= ["--context=" + $context] + .));

reduce ($cliContexts | to_entries[]) as $cli (.;
  if .command_policies.commands[$cli.key].from.session.invocation_policy.allow == null
  then .
  else .command_policies.commands[$cli.key].from.session.invocation_policy.allow |= [.[] | with_context_variants($cli.value)]
  end)
