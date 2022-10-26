import locale


def verifylocale():
    """A simple function to set the environment to en_US.UTF-8 local"""
    if locale.getlocale() != ('en_US', 'UTF-8'):
        try:
            locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')
            return (None , None)

        except locale.Error as e:
            return (None, e)

    else:
        return (None, None)
