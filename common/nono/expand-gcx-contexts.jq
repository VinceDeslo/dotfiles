def with_gcx_context_variants:
  . as $rule
  | $rule,
    ($rule
      | select(.argv.prefix != null)
      | $gcxContexts[] as $context
      | (.argv.prefix |= ["--context", $context] + .),
        (.argv.prefix |= ["--context=" + $context] + .));

if .command_policies.commands.gcx.from.session.invocation_policy.allow == null
then .
else .command_policies.commands.gcx.from.session.invocation_policy.allow |= [.[] | with_gcx_context_variants]
end
