# (c) 2015, Roman Belyakovsky <ihryamzik@gmail.com>

class FilterModule(object):
    ''' Custom filters are loaded by FilterModule objects '''

    def filters(self):
        ''' FilterModule objects return a dict mapping filter names to
            filter functions. '''
        return {
            'version_max': self.version_max,
            'version_up': self.version_up,
        }

    def version_max(self, value):
        from ansible.runner.filter_plugins.core import version_compare
        max="0.0.0"
        for v in value:
            if len(v) > 0 and version_compare(v, max, '>='):
                max=v
        return max

    def version_up(self, value):
        max = self.version_max(value)
        splitted = map(int, max.split('.'))
        splitted[len(splitted) - 1] += 1
        return '.'.join(map(str, splitted))
