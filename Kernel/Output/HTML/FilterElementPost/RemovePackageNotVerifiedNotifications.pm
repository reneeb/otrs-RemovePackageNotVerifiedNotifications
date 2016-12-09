# --
# Copyright (C) 2016 Perl-Services.de, http://www.perl-services.de/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::FilterElementPost::RemovePackageNotVerifiedNotifications;

use strict;
use warnings;

our @ObjectDependencies = qw(
    Kernel::Output::HTML::Layout
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    $Self->{UserID} = $Param{UserID};

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get template name
    my $Templatename = $Param{TemplateFile} || '';

    return 1 if !$Templatename;
    return 1 if $Templatename ne 'AdminPackageManager';

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $Text         = $LayoutObject->{LanguageObject}->Translate('Package not verified');

    $LayoutObject->AddJSOnDocumentComplete(
        Code => qq~
            \$('.MessageBox').each( function() {
                if ( \$(this).hasClass('Error') && \$(this).find('p').match(/$Text/) ) {
                    \$(this).addClass('Hidden');
                }
            });
        ~,
    );

    return 1;
}

1;
