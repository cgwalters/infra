module.exports = {
  autodiscover: true,
  branchPrefix: 'test-renovate/',
  platform: 'github',
  forkProcessing: 'enabled',
  packageRules: [
    {
      description: 'lockFileMaintenance',
      matchUpdateTypes: [
        'pin',
        'digest',
        'patch',
        'minor',
        'major',
        'lockFileMaintenance',
      ],
      dependencyDashboardApproval: false,
      minimumReleaseAge: '0 days',
    },
  ],
};
