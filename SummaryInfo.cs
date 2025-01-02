using System;
using WindowsInstaller;

class Program
{
    static void Main(string[] args)
    {
        string msiFilePath = @"C:\path\to\your.msi";  // Path to your MSI file

        try
        {
            // Open the MSI file
            var installer = new Installer();
            var database = installer.OpenDatabase(msiFilePath, DatabaseOpenMode.Direct);

            // Begin a transaction to modify the database
            var transaction = database.BeginTransaction();

            // Set summary information
            UpdateSummaryInformation(database);

            // Commit the changes
            transaction.Commit();
            Console.WriteLine("Summary information updated successfully!");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
        }
    }

    private static void UpdateSummaryInformation(Database database)
    {
        try
        {
            // Access the summary information table
            var summaryInfo = database.SummaryInformation;

            // Set metadata fields (Title, Author, etc.)
            summaryInfo.Title = "My MSI Title";
            summaryInfo.Author = "My Company Name";
            summaryInfo.Subject = "My MSI Subject";
            summaryInfo.Keywords = "Keywords, MSI";
            summaryInfo.Comments = "This is a comment about the MSI file.";
            summaryInfo.LastAuthor = "Last Author Name";
            summaryInfo.Template = "MyTemplate";
            summaryInfo.RevisionNumber = 1;

            // Commit the changes to the summary info
            summaryInfo.Save();
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error updating summary information: {ex.Message}");
        }
    }
}
