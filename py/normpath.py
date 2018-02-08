__doc__ = ''' This is a class for normalizing a path to either
Windows or Unix.

You can supply a path yourself or it will use the text in your
Windows clipboard.

This uses the click framework to create a command line utility

Args:
    --path (str)
        * The path to normalize
        * If not supplied the tool grabs the string from the 
        Windwows clipboard

Flags:
    --unix
        * normalizes the path to unix

    --force
        * skips path validation and simply normalizes the slash characters

'''



import os
import win32clipboard

import click


class NormPath(object):
    
    def __init__(self, path, force=None, unix=None):
        super(NormPath, self).__init__()

        self.path = path
        self.force = force
        self.unix = unix

    def validate_path(self, path):
        ''' Attempts to validate the inputed string as a path '''

        if self.force:
            return True

        out = False

        try:
            if not os.path.isfile(path) or not os.path.isdir(path):
                out = True
        except:
            pass

        return out

    def get_clipboard(self):
        ''' Returns the clipboard string

        if not self.force:
            attempts to validate the clipboard text as a path

        Will remove double quatations from the string
        
        returns:
            (str)

        '''

        win32clipboard.OpenClipboard()
        data = win32clipboard.GetClipboardData()
        win32clipboard.CloseClipboard()

        data = data.replace('"', '')

        if not self.validate_path(data):
            raise ValueError('You do not have a valid path in your clipboard') 

        return data

    def set_clipboard(self, path):
        '''Sets the Windows clipboard text to the inputed path string

        Args:
            path (str)

        returns:
            (void)

        '''

        win32clipboard.OpenClipboard()
        win32clipboard.EmptyClipboard()
        win32clipboard.SetClipboardText(path)
        win32clipboard.CloseClipboard()

    def windowsify(self):
        ''' normalizes the value in self.path to Windows 
        
        Sets the Windows clipboard text to the normalized string

        returns:
            (str)

        '''

        path = self.path or self.get_clipboard()
        nText = path.replace('/','\\')
        self.set_clipboard(nText)
        return nText

    def linuxify(self, path=None):
        ''' normalizes the value in self.path to Unix 
        
        Sets the Windows clipboard text to the normalized string

        returns:
            (str)
            
        '''

        path = self.path or self.get_clipboard()
        nText = path.replace('\\','/')
        self.set_clipboard(nText)
        return nText

    def _execute(self):
        '''Main logic

        See Also:
            linuxify()
            windowsify()

        '''

        if self.unix:
            self.linuxify()
        else:
            self.windowsify()



@click.command()
@click.option('--unix', is_flag=True)
@click.option('--force', is_flag=True)
@click.option('--path', default=None)
def main(path, force, unix):
    '''
    '''
    normPath = NormPath(path, force, unix)
    normPath._execute()


if __name__ == "__main__":
   main()