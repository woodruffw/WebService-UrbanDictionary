package WebService::UrbanDictionary::Term;

# ABSTRACT: The Term object filled by WebService::UrbanDictionary objects.

use Moo;
use WebService::UrbanDictionary::Term::Definition;

has 'term'        => ( is => 'ro' );
has 'tags'        => ( is => 'ro' );
has 'result_type' => ( is => 'ro' );
has 'definitions' => ( is => 'ro' );
has 'sounds'      => ( is => 'ro' );

sub BUILD {
	my $self = shift;
	my $params = shift;
	$self->{definitions} = [
		map { WebService::UrbanDictionary::Term::Definition->new($_) } @{$params->{list}}
	];
}

sub definition {
	my $defs = shift->definitions;
	return (wantarray ? @$defs : $defs->[0]->definition);
}

1;

=for Pod::Coverage BUILD
=for Pod::Coverage term
=for Pod::Coverage tags
=for Pod::Coverage result_type
=for Pod::Coverage definitions
=for Pod::Coverage sounds

=head1 NAME

WebService::UrbanDictionary::Term - Object for holding definitions and other data requested by L<WebService::UrbanDictionary>.

=head1 SYNOPSIS

	use WebService::UrbanDictionary;

	my $ud = WebService::UrbanDictionary->new;

	my $results = $ud->request('perl'); 

	my $definition = $results->definition;

=head1 DESCRIPTION

WebService::UrbanDictionary::Term objects are returned by the C< request(word) > method
of L<WebService::UrbanDictionary> objects upon successfully retreiving data from UrbanDictionary.com's 
JSON API.

=head2 Methods

=over 12

=item C<< definition >>

Returns either an array of hashes containing API data, or the first definition of the word depending on context.
These elements can then be accessed with the methods in L<WebService::UrbanDictionary::Term::Definition>.

=back

=head1 SEE ALSO

L<WebService::UrbanDictionary>

L<WebService::UrbanDictionary::Term::Definition>

=cut
