package Test::Data::Split::Backend::Hash;

use strict;
use warnings;

use List::MoreUtils qw/notall/;


sub new
{
    my $class = shift;

    my $self = bless {}, $class;

    $self->_init(@_);

    return $self;
}

sub _hash
{
    my $self = shift;

    if (@_)
    {
        $self->{_hash} = shift;
    }

    return $self->{_hash};
}

sub _init
{
    my ($self, $args) = @_;

    my $hash_ref = $self->get_hash;

    if (notall { /\A[A-Za-z_\-0-9]{1,80}\z/ } keys (%$hash_ref))
    {
        die "Invalid key in hash reference. All keys must be alphanumeric plus underscores and dashes.";
    }
    $self->_hash($hash_ref);

    return;
}

sub list_ids
{
    my ($self) = @_;

    return [ sort { $a cmp $b } keys(%{$self->_hash}) ];
}

sub lookup_data
{
    my ($self, $id) = @_;

    return $self->_hash->{$id};
}

1;

__END__

=pod

=head1 NAME

Test::Data::Split::Backend::Hash - hash backend.

=head1 VERSION

version 0.0.1

=head1 SYNOPSIS

    package DataSplitHashTest;

    use strict;
    use warnings;

    use parent 'Test::Data::Split::Backend::Hash';

    my %hash =
    (
        a => { more => "Hello"},
        b => { more => "Jack"},
        c => { more => "Sophie"},
        d => { more => "Danny"},
        'e100_99' => { more => "Zebra"},
    );

    sub get_hash
    {
        return \%hash;
    }

    1;

=head1 DESCRIPTION

This is a hash backend for L<Test::Data::Split> .

=head1 METHODS

=head2 new()

For internal use.

=head2 $obj->lookup_data($id)

Looks up the data with the ID $id.

=head2 $obj->list_ids()

Lists the IDs - needed by Test::Data::Split;

=head2 $obj->get_hash()

This method should be implemented and return a hash reference to the
keys/values of the data.

=head1 AUTHOR

Shlomi Fish <shlomif@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Shlomi Fish.

This is free software, licensed under:

  The MIT (X11) License

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Data-Split or by email to
bug-test-data-split@rt.cpan.org.

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=for :stopwords cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Perldoc

You can find documentation for this module with the perldoc command.

  perldoc Test::Data::Split

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

MetaCPAN

A modern, open-source CPAN search engine, useful to view POD in HTML format.

L<http://metacpan.org/release/Test-Data-Split>

=item *

Search CPAN

The default CPAN search engine, useful to view POD in HTML format.

L<http://search.cpan.org/dist/Test-Data-Split>

=item *

RT: CPAN's Bug Tracker

The RT ( Request Tracker ) website is the default bug/issue tracking system for CPAN.

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Data-Split>

=item *

AnnoCPAN

The AnnoCPAN is a website that allows community annotations of Perl module documentation.

L<http://annocpan.org/dist/Test-Data-Split>

=item *

CPAN Ratings

The CPAN Ratings is a website that allows community ratings and reviews of Perl modules.

L<http://cpanratings.perl.org/d/Test-Data-Split>

=item *

CPAN Forum

The CPAN Forum is a web forum for discussing Perl modules.

L<http://cpanforum.com/dist/Test-Data-Split>

=item *

CPANTS

The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

L<http://cpants.perl.org/dist/overview/Test-Data-Split>

=item *

CPAN Testers

The CPAN Testers is a network of smokers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/T/Test-Data-Split>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

L<http://matrix.cpantesters.org/?dist=Test-Data-Split>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=Test::Data::Split>

=back

=head2 Bugs / Feature Requests

Please report any bugs or feature requests by email to C<bug-test-data-split at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-Data-Split>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<https://github.com/shlomif/perl-Test-Data-Split>

  git clone https://github.com/shlomif/perl-Test-Data-Split.git

=cut
